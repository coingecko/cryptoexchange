module Cryptoexchange::Exchanges
  module Coinpulse
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
          # See comments here: https://github.com/coingecko/cryptoexchange/pull/1064
          # As of 11/04/18 ticker urls don't return the correct volume value
          # Need to use a endpoint to retrieve all tickers instead
          "#{Cryptoexchange::Exchanges::Coinpulse::Market::API_URL}/returnTicker"
        end

        def adapt_all(output)
          output.map do |key, pair|
              base, target = key.split("_")
              market_pair = Cryptoexchange::Models::MarketPair.new(
                base: base,
                target: target,
                market: Coinrail::Market::NAME
              )

              adapt(pair, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker = Cryptoexchange::Models::Ticker.new
          base = market_pair.base
          target = market_pair.target

          ticker.base      = base
          ticker.target    = target
          ticker.market    = Coinpulse::Market::NAME
          ticker.ask       = NumericHelper.to_d(output['lowestAsk'])
          ticker.bid       = NumericHelper.to_d(output['highestBid'])
          ticker.high      = NumericHelper.to_d(output['high24hr'])
          ticker.last      = NumericHelper.to_d(output['last'])
          ticker.volume    = NumericHelper.to_d(output['baseVolume'])

          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
