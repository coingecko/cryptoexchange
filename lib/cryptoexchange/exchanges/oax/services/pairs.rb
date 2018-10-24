module Cryptoexchange::Exchanges
  module Oax
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Oax::Market::API_URL}/market/getAllMarketInfo"
        HTTP_METHOD = 'POST'

        def fetch
          output = super
          market_pairs = []
          output['data'].each do |pair|
            base, target = pair[0].split('/')
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              market: Oax::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
