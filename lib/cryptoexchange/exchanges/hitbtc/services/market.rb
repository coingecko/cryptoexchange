require 'bigdecimal'

module Cryptoexchange::Exchanges
  module Hitbtc
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
          symbol = "#{market_pair.base}#{market_pair.target}"
          "#{Cryptoexchange::Exchanges::Hitbtc::Market::API_URL}/public/ticker/#{symbol}"
        end

        def adapt(output, market_pair)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Hitbtc::Market::NAME
          ticker.last      = NumericHelper.to_d(output['last'])
          ticker.bid       = NumericHelper.to_d(output['bid'])
          ticker.ask       = NumericHelper.to_d(output['ask'])
          ticker.high      = NumericHelper.to_d(output['high'])
          ticker.low       = NumericHelper.to_d(output['low'])
          ticker.volume    = NumericHelper.to_d(output['volume'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
