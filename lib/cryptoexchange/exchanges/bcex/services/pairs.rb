module Cryptoexchange::Exchanges
  module Bcex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL   = "#{Cryptoexchange::Exchanges::Bcex::Market::API_URL}/rt/getTradeLists"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          pairs_list = []
          all_tickers = []
          output["data"]["main"].map do |tickers|
            tickers[1].map do |t|
             all_tickers << t
            end
          end

          all_tickers.map do |ticker|
            base, target = ticker["token"], ticker["market"]
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Bcex::Market::NAME
            )
          end
        end
      end
    end
  end
end
