module Cryptoexchange::Exchanges
  module Nash
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          headers = { content_type: "application/json" }
          body = '{"operationName":"Tickers","variables":{},"query":"query Tickers {\n  listTickers {\n    ...tickerFields\n    __typename\n  }\n}\n\nfragment tickerFields on Ticker {\n  id\n  market {\n    ...marketFields\n    __typename\n  }\n  priceChange_24hPct\n  highPrice_24h {\n    ...currencyPriceFields\n    __typename\n  }\n  lowPrice_24h {\n    ...currencyPriceFields\n    __typename\n  }\n  volume_24h {\n    ...currencyAmountFields\n    __typename\n  }\n  lastPrice {\n    ...currencyPriceFields\n    __typename\n  }\n  usdLastPrice {\n    ...currencyPriceFields\n    __typename\n  }\n  usdLastPriceB {\n    ...currencyPriceFields\n    __typename\n  }\n  bestBidPrice {\n    ...currencyPriceFields\n    __typename\n  }\n  bestAskPrice {\n    ...currencyPriceFields\n    __typename\n  }\n  __typename\n}\n\nfragment currencyAmountFields on CurrencyAmount {\n  amount\n  currency\n  __typename\n}\n\nfragment currencyPriceFields on CurrencyPrice {\n  amount\n  currencyA\n  currencyB\n  __typename\n}\n\nfragment marketFields on Market {\n  aAsset {\n    ...assetFields\n    __typename\n  }\n  aUnit\n  aUnitPrecision\n  bAsset {\n    ...assetFields\n    __typename\n  }\n  bUnit\n  bUnitPrecision\n  id\n  minTickSize\n  minTradeSize\n  minTradeSizeB\n  minTradeIncrement\n  minTradeIncrementB\n  name\n  status\n  priceGranularity\n  primary\n  __typename\n}\n\nfragment assetFields on Asset {\n  blockchain\n  blockchainPrecision\n  depositPrecision\n  hash\n  name\n  symbol\n  withdrawalPrecision\n  __typename\n}\n"}'   

          output = JSON.parse(HTTP.post(ticker_url, headers: headers, body: body))
          adapt_all(output)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Nash::Market::API_URL}/graphql"
        end

        def adapt_all(output)
          output["data"]["listTickers"].map do |output|
            if output["market"]["primary"] == true
              base, target = output["market"]["name"].split('_')
              market_pair = Cryptoexchange::Models::MarketPair.new(
                              base: base.upcase,
                              target: target.upcase,
                              market: Nash::Market::NAME
                            )

              adapt(market_pair, output)
            end
          end.compact
        end

        def adapt(market_pair, output)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Nash::Market::NAME
          if output['lastPrice'] != nil
            ticker.last      = NumericHelper.to_d(output['lastPrice']['amount'])
            ticker.high      = NumericHelper.to_d(output['highPrice_24h']['amount'])
            ticker.low       = NumericHelper.to_d(output['lowPrice_24h']['amount'])
            ticker.bid       = NumericHelper.to_d(output['bestBidPrice']['amount'])
            ticker.ask       = NumericHelper.to_d(output['bestAskPrice']['amount'])
            ticker.volume    = NumericHelper.to_d(output['volume_24h']['amount']) / ticker.last
          else
            ticker.last      = nil
            ticker.high      = nil
            ticker.low       = nil
            ticker.bid       = nil
            ticker.ask       = nil
            ticker.volume    = nil
          end
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
