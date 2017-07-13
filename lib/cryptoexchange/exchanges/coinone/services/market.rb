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
          ticker.last      = output['last'] ? BigDecimal.new(output['last'].to_s) : nil
          ticker.high      = output['high'] ? BigDecimal.new(output['high'].to_s) : nil
          ticker.low       = output['low'] ? BigDecimal.new(output['low'].to_s) : nil
          ticker.volume    = output['volume'] ? BigDecimal.new(output['volume'].to_s) : nil
          ticker.timestamp = output['timestamp'].to_i
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
