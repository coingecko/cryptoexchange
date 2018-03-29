module Cryptoexchange::Exchanges
  module Cobinhood
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
          trading_pair_id = "#{market_pair.base}-#{market_pair.target}"
          "#{Cryptoexchange::Exchanges::Cobinhood::Market::API_URL}/market/tickers/#{trading_pair_id}"
        end

        def adapt(output, market_pair)
          ticker = Cryptoexchange::Models::Ticker.new
          market = output['result']["ticker"]

          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Cobinhood::Market::NAME
          ticker.last      = NumericHelper.to_d(market['last_trade_price'])
          ticker.high      = NumericHelper.to_d(market['24h_high'])
          ticker.low       = NumericHelper.to_d(market['24h_low'])
          ticker.ask       = NumericHelper.to_d(market['lowest_ask'])
          ticker.bid       = NumericHelper.to_d(market['highest_bid'])
          ticker.volume    = NumericHelper.to_d(market['24h_volume'])
          ticker.timestamp = DateTime.now.to_time.to_i
          ticker.payload   = market
          ticker
        end
      end
    end
  end
end
