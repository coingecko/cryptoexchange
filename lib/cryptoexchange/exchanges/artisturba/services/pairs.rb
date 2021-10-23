module Cryptoexchange::Exchanges
  module Artisturba
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Artisturba::Market::API_URL}/tickers"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output["combinations"].map do |ticker|
            base, target = ticker[0].split('_')
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Artisturba::Market::NAME
            )
          end
        end
      end
    end
  end
end
