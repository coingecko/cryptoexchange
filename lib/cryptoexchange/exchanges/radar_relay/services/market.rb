module Cryptoexchange::Exchanges
  module RadarRelay
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(market_pair, output)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::RadarRelay::Market::API_URL}/ticker/#{market_pair.base}/#{market_pair.target}"
        end

        def adapt(market_pair, output)
          ticker = Cryptoexchange::Models::Ticker.new

          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = RadarRelay::Market::NAME
          ticker.last      = value_divisor(NumericHelper.to_d(output['last']))
          ticker.high      = output['high'] == "NA" ? nil : value_divisor(NumericHelper.to_d(output['high']))
          ticker.low       = output['low'] == "NA" ? nil : value_divisor(NumericHelper.to_d(output['low']))
          ticker.volume    = NumericHelper.to_d(output['baseVolume'])
          ticker.timestamp = Time.now.to_i
          ticker.payload   = output
          ticker
        end

        private

        def value_divisor(amount)
          return if amount.zero?
          # For radar_relay, price denominated in different format
          1.0/amount
        end
      end
    end
  end
end
