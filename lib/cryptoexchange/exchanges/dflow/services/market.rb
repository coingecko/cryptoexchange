module Cryptoexchange::Exchanges
  module Dflow
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
          pair = "#{market_pair.base}#{ market_pair.target}".downcase
          "#{Cryptoexchange::Exchanges::Dflow::Market::API_URL}/market/ticker?symbol=#{pair}"
        end

        def adapt(output, market_pair)
          data = output["data"]["#{market_pair.base}#{ market_pair.target}".downcase]

          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Dflow::Market::NAME

          ticker.last      = NumericHelper.to_d(data['last'])
          ticker.high      = NumericHelper.to_d(data['high'])
          ticker.low       = NumericHelper.to_d(data['low'])
          ticker.bid       = NumericHelper.to_d(data['buy'])
          ticker.ask       = NumericHelper.to_d(data['sell'])
          ticker.volume    = NumericHelper.to_d(data['vol'])

          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
