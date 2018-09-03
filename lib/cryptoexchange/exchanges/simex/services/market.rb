module Cryptoexchange::Exchanges
  module Simex
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
          "#{Cryptoexchange::Exchanges::Simex::Market::API_URL}"
        end

        def adapt_all(output)
          output['data'].map do |pair|
            base = pair['base']['name']
            target = pair['quote']['name']
            market_pair = Cryptoexchange::Models::MarketPair.new(
                            base: base,
                            target: target,
                            market: Simex::Market::NAME
            )
            adapt(market_pair, pair)
          end
        end

        def adapt(market_pair, output)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = Simex::Market::NAME

          ticker.last = NumericHelper.to_d(output['last_price'])
          ticker.ask = NumericHelper.to_d(output['sell_price'])
          ticker.bid = NumericHelper.to_d(output['buy_price'])
          ticker.change = NumericHelper.to_d(output['change_percent'])
          ticker.volume = NumericHelper.to_d(output['base_volume'])
          ticker.high = NumericHelper.to_d(output['high_price'])
          ticker.low = NumericHelper.to_d(output['low_price'])

          ticker.timestamp = nil
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
