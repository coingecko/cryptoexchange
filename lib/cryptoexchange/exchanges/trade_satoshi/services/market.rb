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
        #   "market":"LTC_BTC",
        #   "high":0.01749999,
        #   "low":0.01520006,
        #   "volume":469.05469918,
        #   "baseVolume":7.71450537,
        #   "last":0.01680000,
        #   "bid":0.01680000,
        #   "ask":0.01699999,
        #   "openBuyOrders":59,
        #   "openSellOrders":70,
        #   "change":0.0
        # }
        def adapt(output, market_pair)
          market = output
          # raise output.inspect
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = TradeSatoshi::Market::NAME
          ticker.ask = NumericHelper.to_d(market['ask'])
          ticker.bid = NumericHelper.to_d(market['bid'])
          ticker.last = NumericHelper.to_d(market['last'])
          ticker.high = NumericHelper.to_d(market['high'])
          ticker.low = NumericHelper.to_d(market['low'])
          ticker.volume = NumericHelper.to_d(market['volume'])
          ticker.timestamp = DateTime.now.to_time.to_i
          ticker.payload = market
          ticker
        end
      end
    end
  end
end
