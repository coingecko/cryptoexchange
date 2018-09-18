module Cryptoexchange::Exchanges
  module Altmarkets
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Altmarkets::Market::API_URL}/public/getmarkets"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['result'].map do |pair|
            next if pair['IsActive'] == false || pair['MarketCurrency'] == pair['BaseCurrency']
            Cryptoexchange::Models::MarketPair.new(
              base:   pair['MarketCurrency'],
              target: pair['BaseCurrency'],
              market: Altmarkets::Market::NAME
            )
          end.compact
        end
      end
    end
  end
end
