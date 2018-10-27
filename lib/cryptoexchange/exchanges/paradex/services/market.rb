module Cryptoexchange::Exchanges
  module Paradex
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          authentication = Cryptoexchange::Exchanges::Paradex::Authentication.new(
            :market,
            Paradex::Market::NAME
          )
          authentication.validate_credentials!

          headers = authentication.headers(nil)
          ticker  = Cryptoexchange::Exchanges::Paradex::Market.fetch_via_api(ticker_url(market_pair), headers)
          ohlcv   = Cryptoexchange::Exchanges::Paradex::Market.fetch_via_api(ohlcv_url(market_pair), headers)
          adapt(ticker, ohlcv, market_pair)
        end

        def ticker_url(market_pair)
          base   = market_pair.base
          target = market_pair.target
          "#{Cryptoexchange::Exchanges::Paradex::Market::API_URL}/v0/ticker?market=#{base}/#{target}"
        end

        PERIOD = '1d'
        AMOUNT = '1'

        def ohlcv_url(market_pair)
          base   = market_pair.base
          target = market_pair.target
          "#{Cryptoexchange::Exchanges::Paradex::Market::API_URL}/v0/ohlcv?market=#{base}/#{target}&period=#{PERIOD}&amount=#{AMOUNT}"
        end

        def adapt(output, ohlcv, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Paradex::Market::NAME
          ticker.ask       = NumericHelper.to_d(output['ask'])
          ticker.bid       = NumericHelper.to_d(output['bid'])
          ticker.last      = NumericHelper.to_d(output['last'])
          ticker.high      = NumericHelper.to_d(ohlcv.first['high'])
          ticker.low       = NumericHelper.to_d(ohlcv.first['low'])
          ticker.volume    = NumericHelper.to_d(ohlcv.first['volume'])
          ticker.timestamp = Time.parse(ohlcv.first['date']).to_i
          ticker.payload   = { ticker_info: output, ohlcv_info: ohlcv }
          puts ticker.payload
          ticker
        end
      end
    end
  end
end
