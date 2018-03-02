module Cryptoexchange::Exchanges
  module Lbank
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
          market = "#{market_pair.base}_#{market_pair.target}".downcase
          "#{Cryptoexchange::Exchanges::Lbank::Market::API_URL}/ticker.do/?symbol=#{market}"
        end

        def adapt(output,market_pair)
          ticker_json = output['ticker']
          
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Lbank::Market::NAME

          ticker.change    = NumericHelper.to_d(ticker_json['change'])
          ticker.high      = NumericHelper.to_d(ticker_json['high'])
          ticker.last      = NumericHelper.to_d(ticker_json['latest'])
          ticker.low       = NumericHelper.to_d(ticker_json['low'])
          ticker.volume    = NumericHelper.to_d(ticker_json['vol'])
                  
          ticker.timestamp = output['timestamp']
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end

