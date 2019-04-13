module Cryptoexchange::Exchanges
  module BinanceUganda
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
          base = market_pair.base
          target = market_pair.target
          "#{Cryptoexchange::Exchanges::BinanceUganda::Market::API_URL}/ticker/24hr?symbol=#{base}#{target}"
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = BinanceUganda::Market::NAME
          ticker.bid       = NumericHelper.to_d(output['bidPrice'])
          ticker.ask       = NumericHelper.to_d(output['askPrice'])
          ticker.last      = NumericHelper.to_d(output['lastPrice'])
          ticker.high      = NumericHelper.to_d(output['highPrice'])
          ticker.low       = NumericHelper.to_d(output['lowPrice'])
          ticker.volume    = NumericHelper.to_d(output['volume'])
          ticker.timestamp = output['closeTime'].to_i / 1000
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
