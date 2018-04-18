require "http"

module Cryptoexchange::Exchanges
  module Coinlink
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          secret_header = Digest::SHA256.hexdigest('TEST1bot_key')
          raw_output = HTTP.headers(:SecretHeader => secret_header).get(ticker_url)
          output = JSON.parse(raw_output)
          puts output
          adapt_all(output)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Coinlink::Market::API_URL}/ticker?apiKey=TEST1"
        end

        def adapt_all(output)
          output['data'].map do |data|
            data.map do |base, ticker|
              target = 'KRW'
              market_pair = Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              market: Coinlink::Market::NAME
                            )
              adapt(ticker, market_pair)
            end
          end
        end

        def adapt(output, market_pair)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = Coinlink::Market::NAME

          ticker.last = NumericHelper.to_d(output['close_price'])
          ticker.timestamp = output['date'].to_i
          ticker.payload = output
          ticker
        end
      end   
    end
  end
end
