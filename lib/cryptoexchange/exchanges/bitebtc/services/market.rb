module Cryptoexchange::Exchanges
  module Bitebtc
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
          "#{Cryptoexchange::Exchanges::Bitebtc::Market::API_URL}/market"
        end

        def adapt_all(output)
          markets = output['result']
          markets.map do |value|
            base, target = value['market'].split('_')
            market_pair = Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Bitebtc::Market::NAME
            )
            adapt(value, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Bitebtc::Market::NAME
          ticker.last      = NumericHelper.to_d(output['price'])
          ticker.high      = NumericHelper.to_d(output['high'])
          ticker.low       = NumericHelper.to_d(output['low'])
          ticker.volume    = NumericHelper.to_d(output['volume'])
          ticker.change    = NumericHelper.to_d(output['percent'])
          ticker.timestamp = output['timestamp']
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
