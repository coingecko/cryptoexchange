module Cryptoexchange::Exchanges
  module Txbit
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
          base = market_pair.base
          target = market_pair.target
          "#{Cryptoexchange::Exchanges::Txbit::Market::API_URL}/public/getmarketsummary?market=#{target}/#{base}"
        end

        def adapt(output, market_pair)
          handle_invalid(output)
          ticker = Cryptoexchange::Models::Ticker.new
          market = output['result']

          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Txbit::Market::NAME
          ticker.last      = NumericHelper.to_d(market['Last'])
          ticker.high      = NumericHelper.to_d(market['High'])
          ticker.low       = NumericHelper.to_d(market['Low'])
          ticker.ask       = NumericHelper.to_d(market['Ask'])
          ticker.bid       = NumericHelper.to_d(market['Bid'])
          ticker.volume    = NumericHelper.to_d(market['BaseVolume'])
          ticker.timestamp = NumericHelper.to_d(DateTime.parse(market['TimeStamp']).to_time.to_i)
          ticker.payload   = market
          ticker
        end

        def handle_invalid(output)
          if output['message'] == 'INVALID_MARKET'
            raise Cryptoexchange::ResultParseError, { response: output }
          end
        end
      end
    end
  end
end
