module Cryptoexchange::Exchanges
  module Nebula
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Nebula::Market::API_URL}/v1/symbols"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.collect do |pair|
            Cryptoexchange::Models::MarketPair.new(
              base: pair['token'],
              target: pair['against'],
              market: Nebula::Market::NAME
            )
          end
        end
      end
    end
  end
end
