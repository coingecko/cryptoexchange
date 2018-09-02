module Cryptoexchange::Exchanges
  module Coinsbank
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end
        
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output.first, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Coinsbank::Market::API_URL}/trade/ohlcv?pairCode=#{market_pair.base}#{market_pair.target}&interval=300"
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Coinsbank::Market::NAME
          ticker.low       = NumericHelper.to_d(output['l'])
          ticker.high      = NumericHelper.to_d(output['h'])
          ticker.last      = NumericHelper.to_d(output['c'])
          ticker.volume    = NumericHelper.to_d(output['v'])
          ticker.timestamp = output['date']/1000
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
