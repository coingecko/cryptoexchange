module Cryptoexchange::Exchanges
  module Cryptex
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
          base   = market_pair.base.downcase
          target = market_pair.target.downcase
          "#{Cryptoexchange::Exchanges::Cryptex::Market::API_URL}/#{base}_#{target}/ticker"
        end

        def adapt(output, market_pair)
          data             = output['data']
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Cryptex::Market::NAME
          ticker.last      = NumericHelper.to_d(data['last'])
          ticker.high      = NumericHelper.to_d(data['high'])
          ticker.low       = NumericHelper.to_d(data['low'])
          ticker.volume    = NumericHelper.divide(NumericHelper.to_d(data['volume']), ticker.last)
          ticker.timestamp = Time.now.to_i
          ticker.payload   = data
          ticker
        end

      end
    end
  end
end
