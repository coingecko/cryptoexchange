module Cryptoexchange::Exchanges
  module Galleon
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
          "#{Cryptoexchange::Exchanges::Galleon::Market::API_URL}/tickers.json"
        end

        def adapt_all(output)
          output.map do |pair, value|
            base = "grin"
            target = pair.split("grin").last
            market_pair = Cryptoexchange::Models::MarketPair.new(
                base: base,
                target: target,
                market: Galleon::Market::NAME
            )
            adapt(value, market_pair)
          end
        end

        def adapt(output, market_pair)
          # Other fields on output that are not used: start24h, change24h
          # No values assigned to ticker fields: ask, bid

          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Galleon::Market::NAME
          ticker.last      = NumericHelper.to_d(output['ticker']['last'])
          ticker.volume    = NumericHelper.to_d(output['ticker']['vol'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
