module Cryptoexchange::Exchanges
  module Currency
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Currency::Market::API_URL}/api/v1/token_crypto/ticker"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |key, pair|
              Cryptoexchange::Models::MarketPair.new({
                base: pair['base_currency'],
                target: pair['quote_currency'],
                market: Currency::Market::NAME
              })
          end.compact
        end
      end
    end
  end
end
