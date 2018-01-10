module Cryptoexchange::Exchanges
  module TradeSatoshi
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          output = super ticker_url
          adapt_all(output)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::TradeSatoshi::Market::API_URL}/getmarketsummaries"
        end

        def adapt_all(output)
          output['result'].map do |ticker|
            base, target = ticker['market'].split('_')
            market_pair = Cryptoexchange::Models::MarketPair.new(
                            base: base,
                            target: target,
                            market: TradeSatoshi::Market::NAME
                          )
            adapt(ticker, market_pair)
          end
        end

        # {
        #   "market":"PAK_BTC",
        #   "high":0.00000000,
        #   "low":0.00000000,
        #   "volume":0.00000000,
        #   "baseVolume":0.00000000,
        #   "last":0.00000070,
        #   "bid":0.00000075,
        #   "ask":0.00000514,
        #   "openBuyOrders":41,
        #   "openSellOrders":13,
        #   "change":0.0
        # },
        def adapt(output, market_pair)
          market = output
          # raise output.inspect
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = TradeSatoshi::Market::NAME
          ticker.ask = NumericHelper.to_d(market['sell'])
          ticker.bid = NumericHelper.to_d(market['buy'])
          ticker.last = NumericHelper.to_d(market['last'])
          ticker.high = NumericHelper.to_d(market['high'])
          ticker.low = NumericHelper.to_d(market['low'])
          ticker.volume = NumericHelper.to_d(market['baseVolume'])
          ticker.timestamp = DateTime.now.to_time.to_i
          ticker.payload = market
          ticker
        end
      end
    end
  end
end
