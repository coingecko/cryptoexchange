module Cryptoexchange::Exchanges
  module Lakebtc
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          output = super(ticker_url)
          adapt_all(output)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Lakebtc::Market::API_URL}/ticker"
        end

        def adapt_all(output)
          tickers = []

          output.keys.each do |pair|
            if pair.include?('btc')
              ticker_json = output[pair]
              ticker = Cryptoexchange::Models::Ticker.new
              ticker.base = 'btc'
              ticker.target = pair[3..-1]
              ticker.market = Lakebtc::Market::NAME

              # NOTE: apparently it can be nil
              ticker.ask    = NumericHelper.to_d(ticker_json['ask'])
              ticker.bid    = NumericHelper.to_d(ticker_json['bid'])
              ticker.last   = NumericHelper.to_d(ticker_json['last'])
              ticker.high   = NumericHelper.to_d(ticker_json['high'])
              ticker.low    = NumericHelper.to_d(ticker_json['low'])
              ticker.volume = NumericHelper.to_d(ticker_json['volume'])

              ticker.timestamp = Time.now.to_i
              ticker.payload = ticker_json

              tickers << ticker
            end
          end

          tickers
        end
      end
    end
  end
end
