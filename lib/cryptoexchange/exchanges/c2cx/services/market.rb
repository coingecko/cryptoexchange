module Cryptoexchange::Exchanges
  module C2cx
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          response = super(ticker_url(market_pair))
          adapt(response, market_pair)
        end

        def ticker_url(market_pair)
          base   = market_pair.base.upcase
          target = market_pair.target.upcase
          "#{Cryptoexchange::Exchanges::C2cx::Market::API_URL}/ticker/?symbol=#{base}_#{target}"
        end

        def adapt(response, market_pair)
          data             = response['data']
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = C2cx::Market::NAME
          ticker.low       = NumericHelper.to_d(data['low'])
          ticker.high      = NumericHelper.to_d(data['high'])
          ticker.last      = NumericHelper.to_d(data['last'])          
          ticker.volume    = NumericHelper.divide(NumericHelper.to_d(data['volume']), ticker.last)
          ticker.timestamp = Time.now.to_i
          ticker.payload   = data
          ticker
        end

      end
    end
  end
end
