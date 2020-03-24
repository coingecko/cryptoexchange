module Cryptoexchange::Exchanges
  module Ddex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Ddex::Market::API_URL}/markets/tickers"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['data']['tickers'].map do |pair|
            base, target = pair['marketId'].split('-')

            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Ddex::Market::NAME
            )
          end
        end
      end
    end
  end
end
