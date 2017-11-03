module Cryptoexchange::Exchanges
  module Abucoins
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Abucoins::Market::API_URL}/products"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |pair|
            Cryptoexchange::Models::MarketPair.new(
              base: pair['base_currency'],
              target: pair['quote_currency'],
              market: Abucoins::Market::NAME
            )
          end
        end
      end
    end
  end
end
