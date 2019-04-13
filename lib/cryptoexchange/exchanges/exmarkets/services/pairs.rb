module Cryptoexchange::Exchanges
  module Exmarkets
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "https://exmarkets.com/api/v1/general/information"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['markets'].map do |pair|
            Cryptoexchange::Models::MarketPair.new(
              base:   pair['currency'],
              target: pair['withCurrency'],
              inst_id: pair['id'],
              market: Exmarkets::Market::NAME
            )
          end
        end
      end
    end
  end
end
