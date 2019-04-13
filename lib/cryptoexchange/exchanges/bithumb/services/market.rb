module Cryptoexchange::Exchanges
  module Bithumb
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
          "#{Cryptoexchange::Exchanges::Bithumb::Market::API_URL}/public/ticker/all"
        end

        def adapt_all(output)
          output['data'].map do |target, ticker|
            base = target
            target = 'KRW'
            market_pair = Cryptoexchange::Models::MarketPair.new(
                            base: base,
                            target: target,
                            market: Bithumb::Market::NAME
                          )
            adapt(ticker, market_pair, output['data']['date'])
          end.compact
        end

        def adapt(output, market_pair, date)
          market = output
          if output.empty?
            nil
          else
            ticker = Cryptoexchange::Models::Ticker.new
            ticker.base = market_pair.base
            ticker.target = market_pair.target
            ticker.market = Bithumb::Market::NAME
            ticker.ask = NumericHelper.to_d(market['sell_price'])
            ticker.bid = NumericHelper.to_d(market['buy_price'])
            ticker.last = NumericHelper.to_d(market['closing_price'])
            ticker.high = NumericHelper.to_d(market['max_price'])
            ticker.low = NumericHelper.to_d(market['min_price'])
            #use 1day volume instead of 7days
            ticker.volume = NumericHelper.to_d(market['volume_1day'])
            ticker.timestamp = date.to_i / 1000
            ticker.payload = market
            ticker
          end
        end
      end
    end
  end
end
