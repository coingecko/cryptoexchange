module Cryptoexchange::Exchanges
  module Paradex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Paradex::Market::API_URL}/v0/markets"

        def fetch
          authentication = Cryptoexchange::Exchanges::Paradex::Authentication.new(
            :pairs,
            Paradex::Market::NAME
          )
          authentication.validate_credentials!

          headers = authentication.headers(nil)
          output  = Cryptoexchange::Exchanges::Paradex::Market.fetch_via_api(PAIRS_URL, headers)
          adapt(output)
        end

        def adapt(output)
          output.map do |pair|
            Cryptoexchange::Models::MarketPair.new(
              base:   pair['baseToken'],
              target: pair['quoteToken'],
              market: Paradex::Market::NAME
            )
          end
        end
      end
    end
  end
end
