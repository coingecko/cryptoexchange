module Cryptoexchange::Exchanges
  module Tradesprite
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          raw_output = HTTP.get(ticker_url)
          output     = JSON.parse(raw_output)
          adapt_all(output)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Tradesprite::Market::API_URL}/ticker"
        end

        def adapt_all(output)
          output['data'].map do |_symbol, value|
            value['stats'].map do |pair, _value|
              ticker_output  = value['stats']
              bid_ask_output = value['prices']
              adapt(pair, ticker_output[pair], bid_ask_output[pair])
            end
          end.flatten
        end

        def adapt(pair, ticker_output, bid_ask_output)
          base, target     = pair.split('-')
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = base
          ticker.target    = target
          ticker.market    = Tradesprite::Market::NAME
          ticker.ask       = NumericHelper.to_d(bid_ask_output['ask_price'])
          ticker.bid       = NumericHelper.to_d(bid_ask_output['bid_price'])
          ticker.last      = NumericHelper.to_d(ticker_output['close_price'])
          ticker.high      = NumericHelper.to_d(ticker_output['high_price'])
          ticker.low       = NumericHelper.to_d(ticker_output['low_price'])
          ticker.volume    = NumericHelper.to_d(ticker_output['volume'])
          ticker.timestamp = nil
          ticker.payload   = [pair, ticker_output, bid_ask_output]
          ticker
        end
      end
    end
  end
end
