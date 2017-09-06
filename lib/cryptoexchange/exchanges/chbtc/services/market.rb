module Cryptoexchange::Exchanges
  module Chbtc
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
          base = market_pair.base.downcase
          target = market_pair.target.downcase
          "#{Cryptoexchange::Exchanges::Chbtc::Market::API_URL}/ticker?currency=#{base}_#{target}"
        end

        def adapt(output, market_pair)
          ticker_data = output['ticker']
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Chbtc::Market::NAME
          ticker.ask       = NumericHelper.to_d(ticker_data['sell'])
          ticker.bid       = NumericHelper.to_d(ticker_data['buy'])
          ticker.last      = NumericHelper.to_d(ticker_data['last'])
          ticker.high      = NumericHelper.to_d(ticker_data['high'])
          ticker.low       = NumericHelper.to_d(ticker_data['low'])
          ticker.volume    = NumericHelper.to_d(ticker_data['vol'])
          ticker.timestamp = output['date'].to_i / 1000
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
