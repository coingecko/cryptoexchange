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
              ticker = Lakebtc::Models::Ticker.new
              ticker.base = 'btc'
              ticker.target = pair[3..-1]
              ticker.market = Lakebtc::Market::NAME

              # NOTE: apparently it can be nil
              ticker.ask = ticker_json['ask'] ? BigDecimal.new(ticker_json['ask']) : nil
              ticker.bid = ticker_json['bid'] ? BigDecimal.new(ticker_json['bid']) : nil
              ticker.last = ticker_json['last'] ? BigDecimal.new(ticker_json['last']) : nil
              ticker.high = ticker_json['high'] ? BigDecimal.new(ticker_json['high']) : nil
              ticker.low = ticker_json['low'] ? BigDecimal.new(ticker_json['low']) : nil
              ticker.volume = ticker_json['volume'] ? BigDecimal.new(ticker_json['volume']) : nil

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
