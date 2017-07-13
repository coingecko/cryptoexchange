module Cryptoexchange::Exchanges
  module Coincheck
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(_)
          output = super(ticker_url(_))
          adapt(output)
        end

        def ticker_url(_)
          "#{Cryptoexchange::Exchanges::Coincheck::Market::API_URL}/ticker"
        end

        def adapt(output)
          ticker           = Coincheck::Models::Ticker.new
          ticker.base      = 'BTC'
          ticker.target    = 'JPY'
          ticker.market    = Coincheck::Market::NAME
          ticker.ask       = output['ask'] ? BigDecimal.new(output['ask'].to_s) : nil
          ticker.bid       = output['bid'] ? BigDecimal.new(output['bid'].to_s) : nil
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
