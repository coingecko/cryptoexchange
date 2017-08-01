module Cryptoexchange::Exchanges
  module Gemini
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
          "#{Cryptoexchange::Exchanges::Gemini::Market::API_URL}/pubticker/#{market_pair.base}#{market_pair.target}"
        end

        def adapt(output, market_pair)
          ticker = Cryptoexchange::Models::Ticker.new

          #this api just have bid and ask like below:
          # {
          #   "bid": "1960.92",
          #   "ask": "1962.82",
          #   "volume": {
          #   "BTC": "13239.1496613005",
          #   "USD": "25256846.437976508553",
          #   "timestamp": 1500257400000
          #   },
          #   "last": "1962.83"
          # }

          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Gemini::Market::NAME
          ticker.ask       = NumericHelper.to_d(output['ask'])
          ticker.bid       = NumericHelper.to_d(output['bid'])
          # this is Base currency's volume
          ticker.volume    = NumericHelper.to_d(output['volume'][market_pair.base])
          ticker.timestamp = output['volume']['timestamp'].to_i
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
