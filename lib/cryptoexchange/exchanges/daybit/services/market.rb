module Cryptoexchange::Exchanges
  module Daybit
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
          "#{Cryptoexchange::Exchanges::Daybit::Market::API_URL}"
        end

        def adapt_all(output)
          output['data'].map do |pair|
            base, target = pair['base'], pair['quote']
            market_pair = Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Daybit::Market::NAME
            )
            adapt(pair, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Daybit::Market::NAME
          ticker.last      = NumericHelper.to_d(output['close'])
          ticker.high      = NumericHelper.to_d(output['high'])
          ticker.low       = NumericHelper.to_d(output['low'])
          ticker.volume    = NumericHelper.to_d(output['base_vol'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
