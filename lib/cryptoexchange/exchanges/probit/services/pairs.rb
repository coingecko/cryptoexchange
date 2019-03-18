module Cryptoexchange::Exchanges
  module Probit
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Probit::Market::API_URL}/market"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['data'].map do |pair|
            next if pair['closed']
            Cryptoexchange::Models::MarketPair.new(
              base:   pair['base_currency_id'],
              target: pair['quote_currency_id'],
              market: Probit::Market::NAME
            )
          end.compact
        end
      end
    end
  end
end
