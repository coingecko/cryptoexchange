module Cryptoexchange::Exchanges
  module Idax
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Idax::Market::API_URL}/GetAllOpenMarkets"
        HTTP_METHOD = 'POST'

        def fetch_via_api
          output = super
          adapt(output)
        end

        def adapt(output)
          output['data'].map do |market|
            Cryptoexchange::Models::MarketPair.new({
              base: market['baseCode'],
              target: market['quoteCode'],
              market: Idax::Market::NAME
            })
          end
        end
      end
    end
  end
end

