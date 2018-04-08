module Cryptoexchange::Exchanges
  module KyberNetwork
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
          "#{Cryptoexchange::Exchanges::KyberNetwork::Market::API_URL}/currencies/convertiblePairs"
        end

        def adapt_all(output)
          tickers = []

          output.keys.each do |pair|
            target, base = pair.split '_'

            ticker_json = output[pair]
            ticker = Cryptoexchange::Models::Ticker.new
            ticker.base = base
            ticker.target = target
            ticker.market = KyberNetwork::Market::NAME

            ticker.last   = NumericHelper.to_d(ticker_json['lastPrice'])
            ticker.volume = NumericHelper.to_d(ticker_json['quoteVolume'])

            ticker.timestamp = ticker_json['lastTimestamp']
            ticker.payload = ticker_json

            tickers << ticker
          end

          tickers
        end
      end
    end
  end
end
