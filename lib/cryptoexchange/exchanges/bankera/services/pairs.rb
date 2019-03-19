module Cryptoexchange::Exchanges
  module Bankera
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bankera::Market::API_URL}/general/info"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['markets'].map do |pair|
            Cryptoexchange::Models::MarketPair.new(
              base:   pair['base_currency'],
              target: pair['quote_currency'],
              market: Bankera::Market::NAME
            )
          end
        end
      end
    end
  end
end
