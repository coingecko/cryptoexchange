module Cryptoexchange::Exchanges
  module Simex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Simex::Market::API_URL}"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['data'].map do |pair, ticker|
            base = pair['base']['name']
            target = pair['quote']['name']
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Simex::Market::NAME
            )
          end
        end
      end
    end
  end
end
