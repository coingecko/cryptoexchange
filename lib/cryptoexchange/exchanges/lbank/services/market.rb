module Cryptoexchange::Exchanges
  module Lbank
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch
          output = super(ticker_url)
          adapt_all(output)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Lbank::Market::API_URL}?symbol=all"
        end

        def adapt_all(output)
          tickers = []

          output.keys.each do |pair|
            if pair.include?('btc') || pair.include?('eth')
              ticker_json = output[pair]
              ticker = Cryptoexchange::Models::Ticker.new
              ticker.base = pair[0..2]
              ticker.target = pair[3..-1]
              ticker.market = Lbank::Market::NAME

              # NOTE: apparently it can be nil
              ticker.change    = NumericHelper.to_d(ticker_json['ask'])
              ticker.high    = NumericHelper.to_d(ticker_json['bid'])
              ticker.latest   = NumericHelper.to_d(ticker_json['last'])
              ticker.low   = NumericHelper.to_d(ticker_json['high'])
              ticker.turnover    = NumericHelper.to_d(ticker_json['low'])
              ticker.vol = NumericHelper.to_d(ticker_json['volume'])

              ticker.timestamp = Time.now.to_i

              tickers << ticker
            end
          end

          tickers
        end
      end
    end
  end
end
