module Cryptoexchange::Exchanges
  module Codex
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
          "#{Cryptoexchange::Exchanges::Codex::Market::API_URL}/tickers"
        end

        def adapt_all(output)
          output['data'].map do |key, ticker|
            market_pair = Cryptoexchange::Models::MarketPair.new(
                base:   ticker['base_unit'],
                target: ticker['quote_unit'],
                market: Codex::Market::NAME
            )

            adapt(market_pair, ticker)
          end
        end

        def adapt(market_pair, output)
          ticker           = Cryptoexchange::Models::Ticker.new

          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Codex::Market::NAME
          ticker.last      = NumericHelper.to_d(output['last'])
          ticker.high      = NumericHelper.to_d(output['high'])
          ticker.low       = NumericHelper.to_d(output['low'])
          ticker.volume    = NumericHelper.to_d(output['volume'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
