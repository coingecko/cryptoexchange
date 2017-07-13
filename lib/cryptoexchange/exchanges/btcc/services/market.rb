module Cryptoexchange::Exchanges
  module Btcc
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
          if market_pair.target == 'USD'
            "#{Cryptoexchange::Exchanges::Btcc::Market::API_URL_USD}/ticker?symbol=#{market_pair.base}#{market_pair.target}"
          else
            "#{Cryptoexchange::Exchanges::Btcc::Market::API_URL_CNY}/ticker?symbol=#{market_pair.base}#{market_pair.target}"
          end
        end

        def adapt(output, market_pair)
          ticker           = Btcc::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Btcc::Market::NAME
          ticker.ask       = output['ticker']['AskPrice'] ? BigDecimal.new(output['ticker']['AskPrice'].to_s) : nil
          ticker.bid       = output['ticker']['BidPrice'] ? BigDecimal.new(output['ticker']['BidPrice'].to_s) : nil
          ticker.last      = output['ticker']['Last'] ? BigDecimal.new(output['ticker']['Last'].to_s) : nil
          ticker.high      = output['ticker']['High'] ? BigDecimal.new(output['ticker']['High'].to_s) : nil
          ticker.low       = output['ticker']['Low'] ? BigDecimal.new(output['ticker']['Low'].to_s) : nil
          ticker.volume    = output['ticker']['Volume'] ? BigDecimal.new(output['ticker']['Volume'].to_s) : nil
          ticker.timestamp = output['ticker']['Timestamp'].to_i
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
