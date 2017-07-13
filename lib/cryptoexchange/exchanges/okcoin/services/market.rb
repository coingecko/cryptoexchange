module Cryptoexchange::Exchanges
  module Okcoin
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
          "#{Cryptoexchange::Exchanges::Okcoin::Market::API_URL}/ticker.do?symbol=#{base}_#{target}"
        end

        def adapt(output, market_pair)
          ticker           = Okcoin::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Okcoin::Market::NAME
          ticker.ask       = output['ticker']['sell'] ? BigDecimal.new(output['ticker']['sell'].to_s) : nil
          ticker.bid       = output['ticker']['buy'] ? BigDecimal.new(output['ticker']['buy'].to_s) : nil
          ticker.last      = output['ticker']['last'] ? BigDecimal.new(output['ticker']['last'].to_s) : nil
          ticker.high      = output['ticker']['high'] ? BigDecimal.new(output['ticker']['high'].to_s) : nil
          ticker.low       = output['ticker']['low'] ? BigDecimal.new(output['ticker']['low'].to_s) : nil
          ticker.volume    = output['ticker']['vol'] ? BigDecimal.new(output['ticker']['vol'].to_s) : nil
          ticker.timestamp = output['date'].to_i
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
