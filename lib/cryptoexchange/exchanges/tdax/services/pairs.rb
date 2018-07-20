module Cryptoexchange::Exchanges
  module Tdax
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Tdax::Market::API_URL}/public/getmarkets"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |pair|
            Cryptoexchange::Models::MarketPair.new(
              base: pair['MarketCurrency'],
              target: pair['BaseCurrency'],
              market: Tdax::Market::NAME
            )
          end
        end
      end
    end
  end
end
