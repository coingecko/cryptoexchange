module Cryptoexchange::Exchanges
  module Oceanex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Oceanex::Market::API_URL}/markets"

        def fetch
          output = super
          adapt(output['data'])
        end

        def adapt(output)
          output.map do |pair|
            base, target = pair['name'].split('/')
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Oceanex::Market::NAME
            )
          end
        end
      end
    end
  end
end
