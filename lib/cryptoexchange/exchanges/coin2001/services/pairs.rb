module Cryptoexchange::Exchanges
  module Coin2001
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Coin2001::Market::API_URL}/v1/public/getMarkets"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['result'].map do |pair|
            next unless pair['IsActive']
            Cryptoexchange::Models::MarketPair.new(
              base: pair['MarketCurrency'],
              target: pair['BaseCurrency'],
              market: Coin2001::Market::NAME
            )
          end.compact
        end
      end
    end
  end
end
