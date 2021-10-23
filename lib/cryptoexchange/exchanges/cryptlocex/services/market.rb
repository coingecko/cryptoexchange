module Cryptoexchange::Exchanges
  module Cryptlocex
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          output = super ticker_url
          adapt_all(output['data']['market'])
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Cryptlocex::Market::API_URL}/Index/marketInfo"
        end

        def adapt_all(output)
          output.map do |output|
            base, target = output["ticker"].split('_')
            market_pair = Cryptoexchange::Models::MarketPair.new(
                            base: base,
                            target: target,
                            market: Cryptlocex::Market::NAME
                          )

            adapt(output, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Cryptlocex::Market::NAME
          ticker.bid       = NumericHelper.to_d(output['buy_price'])
          ticker.ask       = NumericHelper.to_d(output['sell_price'])
          ticker.last      = NumericHelper.to_d(output['new_price'])
          ticker.volume    = NumericHelper.to_d(output['volume'])
          ticker.high      = NumericHelper.to_d(output['max_price'])
          ticker.low       = NumericHelper.to_d(output['min_price'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
