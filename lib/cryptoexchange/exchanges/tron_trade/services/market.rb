module Cryptoexchange::Exchanges
  module TronTrade
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          request = HTTP.accept(:json).post("https://trontrade.io/graphql", json:{"operationName":nil,"variables":{},"query":"{ exchanges { id stats { h24_price high low volume volumeTrx h24_change lastPrice __typename } icon buyAssetName sellAssetName tokenTypeA tokenIdA tokenTypeB tokenIdB tokenDecimalsA tokenDecimalsB site __typename } } " } )
          output = request.parse :json
          adapt_all(output)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::TronTrade::Market::API_URL}"
        end

        def adapt_all(output)
          output['data']['exchanges'].map do |pair|
            target, base = pair['sellAssetName'], pair['buyAssetName']
            market_pair = Cryptoexchange::Models::MarketPair.new(
                base: base,
                target: target,
                market: TronTrade::Market::NAME
              )
            adapt(pair, market_pair)
          end
        end

        def adapt(output, pair)
          price_decimal    = 10**output['tokenDecimalsB'].to_i
          volume_decimal   = 10**output['tokenDecimalsB'].to_i
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = pair.base
          ticker.target    = pair.target
          ticker.market    = Cryptoexchange::Exchanges::TronTrade::Market::NAME
          ticker.last      = NumericHelper.to_d(output['stats']['lastPrice']) / price_decimal
          ticker.high      = NumericHelper.to_d(output['stats']['high']) / price_decimal
          ticker.low       = NumericHelper.to_d(output['stats']['low']) / price_decimal
          ticker.volume    = NumericHelper.to_d(output['stats']['volume']) / volume_decimal
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
