module Cryptoexchange::Exchanges
  module Korbit
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          base = market_pair.base.downcase
          target = market_pair.target.downcase
          "#{Cryptoexchange::Exchanges::Korbit::Market::API_URL}/ticker/detailed?currency_pair=#{base}_#{target}"
        end

        def adapt(output, market_pair)
          ticker           = Korbit::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Korbit::Market::NAME
          ticker.ask       = output['ask'] ? BigDecimal.new(output['ask'].to_s) : nil
          ticker.bid       = output['bid'] ? BigDecimal.new(output['bid'].to_s) : nil
          ticker.last      = output['last'] ? BigDecimal.new(output['last'].to_s) : nil
          ticker.high      = output['high'] ? BigDecimal.new(output['high'].to_s) : nil
          ticker.low       = output['low'] ? BigDecimal.new(output['low'].to_s) : nil
          ticker.volume    = output['volume'] ? BigDecimal.new(output['volume'].to_s) : nil
          ticker.timestamp = output['timestamp'] / 1000
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
