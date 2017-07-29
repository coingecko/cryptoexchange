require 'bigdecimal'

module Cryptoexchange::Exchanges
  module Novaexchange
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
          name = "#{market_pair.target}_#{market_pair.base}"

          "#{Cryptoexchange::Exchanges::Novaexchange::Market::API_URL}/market/info/#{name}/"
        end

        def adapt(output, market_pair)
          market = output['markets'][0]

          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Novaexchange::Market::NAME
          ticker.last      = NumericHelper.to_d(market['last_price'])
          ticker.bid       = NumericHelper.to_d(market['bid'])
          ticker.ask       = NumericHelper.to_d(market['ask'])
          ticker.high      = NumericHelper.to_d(market['high24h'])
          ticker.low       = NumericHelper.to_d(market['low24h'])
          ticker.volume    = NumericHelper.to_d(market['volume24h'])
          ticker.timestamp = Time.now.to_i
          ticker.payload   = market
          ticker
        end
      end
    end
  end
end
