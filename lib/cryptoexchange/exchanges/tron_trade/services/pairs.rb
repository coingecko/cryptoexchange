module Cryptoexchange::Exchanges
  module TronTrade
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::TronTrade::Market::API_URL}"
        HTTP_METHOD = 'POST'

        def fetch
          request = HTTP.accept(:json).post("https://trontrade.io/graphql", json:{"operationName":nil,"variables":{},"query":"{ exchanges { id stats { h24_price high low volume volumeTrx h24_change lastPrice __typename } icon buyAssetName sellAssetName tokenTypeA tokenIdA tokenTypeB tokenIdB tokenDecimalsA tokenDecimalsB site __typename } } " } )
          output = request.parse :json
          adapt(output)
        end

        def adapt(output)
          output["data"]["exchanges"].map do |pair|
            target, base = pair["sellAssetName"], pair["buyAssetName"]
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: TronTrade::Market::NAME
            )
          end
        end
      end
    end
  end
end
