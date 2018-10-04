module Cryptoexchange::Exchanges
  module Uex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Uex::Market::API_URL}/open/api/common/symbols"

        def fetch
          output = super
          adapt(output['data'])
        end

        def adapt(data)
          data.map do |pairs|
            Cryptoexchange::Models::MarketPair.new(
              base: pairs['base_coin'],
              target: pairs['count_coin'],
              market: Uex::Market::NAME
            )
          end
        end
      end
    end
  end
end
