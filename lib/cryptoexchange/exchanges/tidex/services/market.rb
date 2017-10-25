require 'bigdecimal'

module Cryptoexchange::Exchanges
  module Tidex
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
          name = "#{market_pair.base}_#{market_pair.target}".downcase

          "#{Cryptoexchange::Exchanges::Tidex::Market::API_URL}/ticker/#{name}"
        end

        def adapt(output, market_pair)
          name = "#{market_pair.base}_#{market_pair.target}".downcase
          market = output[name]

          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Tidex::Market::NAME
          ticker.last      = NumericHelper.to_d(market['last'])
          ticker.bid       = NumericHelper.to_d(market['buy'])
          ticker.ask       = NumericHelper.to_d(market['sell'])
          ticker.high      = NumericHelper.to_d(market['high'])
          ticker.low       = NumericHelper.to_d(market['low'])
          ticker.volume    = NumericHelper.to_d(market['vol_cur'])
          ticker.timestamp = market['updated'].to_i
          ticker.payload   = market
          ticker
        end
      end
    end
  end
end
