module Cryptoexchange::Exchanges
  module InfinityCoin
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(ticker_url)
          adapt(output, market_pair)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::InfinityCoin::Market::API_URL}/marketapi"
        end

        def adapt(output, market_pair)
          market = output['stats']
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = InfinityCoin::Market::NAME
          ticker.last      = NumericHelper.to_d(market['last_price'])
          ticker.high      = NumericHelper.to_d(market['daily_high'])
          ticker.low       = NumericHelper.to_d(market['daily_low'])
          ticker.volume    = NumericHelper.to_d(market['xin_volume'])
          ticker.timestamp = nil
          ticker.payload   = market
          ticker
        end
      end
    end
  end
end
