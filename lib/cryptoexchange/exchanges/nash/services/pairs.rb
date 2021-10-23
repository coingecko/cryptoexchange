module Cryptoexchange::Exchanges
  module Nash
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Nash::Market::API_URL}/graphql"

        def fetch
          headers = { content_type: "application/json" }
          body = '{"operationName":"Tickers","variables":{},"query":"query Tickers {\n  listTickers {\n    ...tickerFields\n    __typename\n  }\n}\n\nfragment tickerFields on Ticker {\n  id\n  market {\n    ...marketFields\n    __typename\n  }\n  priceChange_24hPct\n  highPrice_24h {\n    ...currencyPriceFields\n    __typename\n  }\n  lowPrice_24h {\n    ...currencyPriceFields\n    __typename\n  }\n  volume_24h {\n    ...currencyAmountFields\n    __typename\n  }\n  lastPrice {\n    ...currencyPriceFields\n    __typename\n  }\n  usdLastPrice {\n    ...currencyPriceFields\n    __typename\n  }\n  usdLastPriceB {\n    ...currencyPriceFields\n    __typename\n  }\n  bestBidPrice {\n    ...currencyPriceFields\n    __typename\n  }\n  bestAskPrice {\n    ...currencyPriceFields\n    __typename\n  }\n  __typename\n}\n\nfragment currencyAmountFields on CurrencyAmount {\n  amount\n  currency\n  __typename\n}\n\nfragment currencyPriceFields on CurrencyPrice {\n  amount\n  currencyA\n  currencyB\n  __typename\n}\n\nfragment marketFields on Market {\n  aAsset {\n    ...assetFields\n    __typename\n  }\n  aUnit\n  aUnitPrecision\n  bAsset {\n    ...assetFields\n    __typename\n  }\n  bUnit\n  bUnitPrecision\n  id\n  minTickSize\n  minTradeSize\n  minTradeSizeB\n  minTradeIncrement\n  minTradeIncrementB\n  name\n  status\n  priceGranularity\n  primary\n  __typename\n}\n\nfragment assetFields on Asset {\n  blockchain\n  blockchainPrecision\n  depositPrecision\n  hash\n  name\n  symbol\n  withdrawalPrecision\n  __typename\n}\n"}'   
          output = JSON.parse(HTTP.post(PAIRS_URL, headers: headers, body: body))
          
          output["data"]["listTickers"].map do |output|
            if output["market"]["primary"] == true
              base, target = output["market"]["name"].split('_')
              Cryptoexchange::Models::MarketPair.new(
                base: base.upcase,
                target: target.upcase,
                market: Nash::Market::NAME
              )
            end
          end.compact
        end
      end
    end
  end
end
