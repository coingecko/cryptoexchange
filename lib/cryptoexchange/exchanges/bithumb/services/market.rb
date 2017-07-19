module Cryptoexchange::Exchanges
  module Bithumb
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Bithumb::Market::API_URL}/public/ticker/#{market_pair.base}"
        end

        def adapt(output, market_pair)
          market = output['data']
          ticker = Bithumb::Models::Ticker.new
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
          ticker.timestamp = market['date'].to_i
          ticker.payload = market
          ticker
        end
      end
    end
  end
end
