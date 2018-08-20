module Cryptoexchange::Exchanges
  module Nanex
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          output = super ticker_url
          adapt_all(output)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Nanex::Market::API_URL}/public/tickers"
        end

        def adapt_all(output)
          output.map do |_pair, ticker|
            base        = ticker['quote']
            target      = ticker['base']
            market_pair = Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Nanex::Market::NAME
            )
            adapt(ticker, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Nanex::Market::NAME
          ticker.last      = NumericHelper.to_d(output['last_trade'])
          ticker.volume    = NumericHelper.to_d(output['quote_volume'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
