module Cryptoexchange::Exchanges
  module CoinflexFutures
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::CoinflexFutures::Market::API_URL}/tickers/"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |ticker|
            if ticker["name"] != ticker["spot_name"]
              base, target = ticker["spot_name"].split("/")
              inst_id = ticker["name"]

              Cryptoexchange::Models::MarketPair.new(
                base: base,
                target: target,
                inst_id: inst_id,
                market: CoinflexFutures::Market::NAME
              )
            end
          end.compact
        end
      end
    end
  end
end
