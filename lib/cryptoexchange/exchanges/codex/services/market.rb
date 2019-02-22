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
          output['data'].map do |key, pair|
            market_pair = Cryptoexchange::Models::MarketPair.new(
                base:   pair['base_unit'],
                target: pair['quote_unit'],
                market: Codex::Market::NAME
            )

            adapt(market_pair, pair)
          end
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair['base_unit']
          ticker.target    = market_pair['quote_unit']
          ticker.market    = Codex::Market::NAME
          ticker.last      = NumericHelper.to_d(market_pair['last'])
          ticker.high      = NumericHelper.to_d(market_pair['high'])
          ticker.low       = NumericHelper.to_d(market_pair['low'])
          ticker.volume    = NumericHelper.to_d(market_pair['volume'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
