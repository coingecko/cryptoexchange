module Cryptoexchange::Exchanges
  module Biztranex
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
          base   = market_pair.base
          target = market_pair.target
          "#{Cryptoexchange::Exchanges::Biztranex::Market::API_URL}/getmarketsummary?market=#{target}-#{base}"
        end

        def adapt(output, market_pair)
          ticker = Cryptoexchange::Models::Ticker.new
          market = output['result']

          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Biztranex::Market::NAME
          ticker.last      = NumericHelper.to_d(market['Last'])
          ticker.high      = NumericHelper.to_d(market['High'])
          ticker.low       = NumericHelper.to_d(market['Low'])
          ticker.change    = NumericHelper.to_d(market['Change'])
          ticker.volume    = NumericHelper.divide(NumericHelper.to_d(market['Volume']), ticker.last)
          ticker.timestamp = NumericHelper.to_d(Time.parse(market['TimeStamp']).to_i)
          ticker.payload   = market
          ticker
        end
      end
    end
  end
end
