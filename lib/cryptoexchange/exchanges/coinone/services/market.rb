module Cryptoexchange::Exchanges
  module Coinone
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output)
        end

        def ticker_url(market_pair)
          base = market_pair.base.downcase
          "#{Cryptoexchange::Exchanges::Coinone::Market::API_URL}/ticker?currency=#{base}"
        end

        def adapt(output)
          ticker           = Coinone::Models::Ticker.new
          ticker.base      = output['currency']
          ticker.target    = 'KRW'
          ticker.market    = Coinone::Market::NAME
          ticker.last      = NumericHelper.to_d(output['last'])
          ticker.high      = NumericHelper.to_d(output['high'])
          ticker.low       = NumericHelper.to_d(output['low'])
          ticker.volume    = NumericHelper.to_d(output['volume'])
          ticker.timestamp = output['timestamp'].to_i
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
