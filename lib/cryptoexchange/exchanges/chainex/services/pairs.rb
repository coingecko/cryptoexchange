module Cryptoexchange::Exchanges
  module Chainex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Chainex::Market::API_URL}/market/summary"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          pairs = output['data']
          pairs.map do |pair|
            Cryptoexchange::Models::MarketPair.new(
              base: pair['code'],
              target: pair['exchange'],
              market: Chainex::Market::NAME
            )
          end
        end
      end
    end
  end
end
