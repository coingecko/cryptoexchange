module Cryptoexchange::Exchanges
  module Ionomy
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
          "#{Cryptoexchange::Exchanges::Ionomy::Market::API_URL}/public/markets-summaries"
        end

        def adapt_all(output)
          output['data'].map do |output|
            target, base = output['market'].split('-')
            market_pair = Cryptoexchange::Models::MarketPair.new(
                            base: base,
                            target: target,
                            market: Ionomy::Market::NAME
                          )

            adapt(output, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Ionomy::Market::NAME
          ticker.bid       = NumericHelper.to_d(output['highestBid'])
          ticker.ask       = NumericHelper.to_d(output['lowestAsk'])
          ticker.last      = NumericHelper.to_d(output['price'])
          ticker.volume    = NumericHelper.to_d(output['volume'])
          ticker.high      = NumericHelper.to_d(output['high'])
          ticker.low       = NumericHelper.to_d(output['low'])
          ticker.change    = NumericHelper.to_d(output['change'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
