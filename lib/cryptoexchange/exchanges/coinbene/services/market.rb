module Cryptoexchange::Exchanges
  module Coinbene
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
          "#{Cryptoexchange::Exchanges::Coinbene::Market::API_URL}/market/ticker?symbol=#{market_pair.base}#{market_pair.target}"
        end

        def adapt(output, market_pair)
          output           = output['ticker'].first

          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Coinbene::Market::NAME
          ticker.last      = NumericHelper.to_d(output['last'])
          ticker.bid       = NumericHelper.to_d(output['bid'])
          ticker.ask       = NumericHelper.to_d(output['ask'])
          ticker.high      = NumericHelper.to_d(output['24hrHigh'])
          ticker.low       = NumericHelper.to_d(output['24hrLow'])
          ticker.volume    = NumericHelper.to_d(output['24hrVol'])
          ticker.timestamp = nil
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
