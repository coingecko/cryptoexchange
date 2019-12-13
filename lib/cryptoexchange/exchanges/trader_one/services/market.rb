module Cryptoexchange::Exchanges
  module TraderOne
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
          "#{Cryptoexchange::Exchanges::TraderOne::Market::API_URL}/markets/tickers?baseCurrency=#{market_pair.base}&quoteCurrency=#{market_pair.target}"
        end

        def adapt(output, market_pair)
          name = "#{market_pair.base}-#{market_pair.target}".upcase
          market = output[name]
          
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = TraderOne::Market::NAME
          ticker.last	   = NumericHelper.to_d(market['last'])
          ticker.ask       = NumericHelper.to_d(market['ask'])
          ticker.bid       = NumericHelper.to_d(market['bid'])
          ticker.last      = NumericHelper.to_d(market['price'])
          ticker.volume    = NumericHelper.to_d(market['baseVolume'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
