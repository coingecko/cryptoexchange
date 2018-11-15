module Cryptoexchange::Exchanges
  module Coinfield
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Coinfield::Market::API_URL}/markets"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['markets'].map do |pair|
            base, target = pair['name'].split('/')
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Coinfield::Market::NAME
            )
          end
        end
      end
    end
  end
end
