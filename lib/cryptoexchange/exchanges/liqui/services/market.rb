require 'bigdecimal'

module Cryptoexchange::Exchanges
  module Liqui
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
          market = "#{market_pair.base}_#{market_pair.target}".downcase
          "#{Cryptoexchange::Exchanges::Liqui::Market::API_URL}/ticker/#{market}"
        end

        def adapt(output, market_pair)
          market = output["#{market_pair.base}_#{market_pair.target}".downcase]

          ticker = Liqui::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Liqui::Market::NAME
          ticker.last      = market['last'] ? BigDecimal.new(market['last'].to_s) : nil
          ticker.bid       = market['buy'] ? BigDecimal.new(market['buy'].to_s) : nil
          ticker.ask       = market['sell'] ? BigDecimal.new(market['sell'].to_s) : nil
          ticker.high      = market['high'] ? BigDecimal.new(market['high'].to_s) : nil
          ticker.low       = market['low'] ? BigDecimal.new(market['low'].to_s) : nil
          ticker.volume    = market['vol'] ? BigDecimal.new(market['vol'].to_s) : nil
          ticker.timestamp = DateTime.now.to_time.to_i
          ticker.payload   = market
          ticker
        end
      end
    end
  end
end
