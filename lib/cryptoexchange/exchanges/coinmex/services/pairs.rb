module Cryptoexchange::Exchanges
  module Coinmex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Coinmex::Market::API_URL}/spot/public/products"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |pair|
            Cryptoexchange::Models::MarketPair.new(
              base: pair['baseCurrency'],
              target: pair['quoteCurrency'],
              market: Coinmex::Market::NAME
            )
          end
        end
      end
    end
  end
end
