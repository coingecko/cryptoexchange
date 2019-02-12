module Cryptoexchange::Exchanges
  module SaturnNetwork
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
          "#{Cryptoexchange::Exchanges::SaturnNetwork::Market::API_URL}/returnTicker.json"
        end

        def adapt_all(output)
          output.map do |pair|
            base = pair[0].split('_').first
            target = pair[1]["symbol"]
            market_pair = Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: SaturnNetwork::Market::NAME
            )
            adapt(pair, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker = Cryptoexchange::Models::Ticker.new

          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = SaturnNetwork::Market::NAME
          ticker.last      = NumericHelper.to_d(output[1]["last"])
          ticker.high      = NumericHelper.to_d(output[1]["highestBid"])
          ticker.low       = NumericHelper.to_d(output[1]["lowestAsk"])
          ticker.volume    = NumericHelper.to_d(output[1]["baseVolume"])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
