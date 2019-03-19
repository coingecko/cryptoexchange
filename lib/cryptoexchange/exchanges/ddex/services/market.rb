require 'bigdecimal'

module Cryptoexchange::Exchanges
  module Ddex
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
          "#{Cryptoexchange::Exchanges::Ddex::Market::API_URL}/markets/tickers"
        end

        def adapt_all(output)
          output['data']['tickers'].map do |pair|
            base, target = pair['marketId'].split('-')
            market_pair = Cryptoexchange::Models::MarketPair.new(
                            base: base,
                            target: target,
                            market: Ddex::Market::NAME
                          )
            adapt(pair, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Ddex::Market::NAME

          ticker.last      = NumericHelper.to_d(output['price'])
          ticker.volume    = NumericHelper.to_d(output['volume'])
          ticker.bid       = NumericHelper.to_d(output['bid'])
          ticker.ask       = NumericHelper.to_d(output['ask'])
          ticker.low       = NumericHelper.to_d(output['low'])
          ticker.high      = NumericHelper.to_d(output['high'])

          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
