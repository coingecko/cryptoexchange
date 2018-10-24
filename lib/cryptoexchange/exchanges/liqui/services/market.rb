require 'bigdecimal'

module Cryptoexchange::Exchanges
  module Liqui
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
          "#{Cryptoexchange::Exchanges::Liqui::Market::API_URL}/ticker/#{market}"
        end

        def adapt(output, market_pair)
          handle_invalid(output)
          market = output["#{market_pair.base}_#{market_pair.target}".downcase]

          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Liqui::Market::NAME
          ticker.last      = NumericHelper.to_d(market['last'])
          ticker.bid       = NumericHelper.to_d(market['buy'])
          ticker.ask       = NumericHelper.to_d(market['sell'])
          ticker.high      = NumericHelper.to_d(market['high'])
          ticker.low       = NumericHelper.to_d(market['low'])
          ticker.volume    = NumericHelper.to_d(market['vol_cur'])
          ticker.timestamp = NumericHelper.to_d(market['updated'])
          ticker.payload   = market
          ticker
        end

        def handle_invalid(output)
          if output['success'] == 0
            raise Cryptoexchange::ResultParseError, { response: output }
          end
        end
      end
    end
  end
end
