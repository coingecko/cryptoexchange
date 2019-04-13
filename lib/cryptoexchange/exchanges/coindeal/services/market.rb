module Cryptoexchange::Exchanges
  module Coindeal
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
          "https://europe1.coindeal.com/api/v1/markets/market/info/?pair=#{market_pair.base}/#{market_pair.target}"
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Coindeal::Market::NAME
          ticker.last      = NumericHelper.to_d(output['lastPrice'])
          ticker.high      = NumericHelper.to_d(output['price24high'])
          ticker.low       = NumericHelper.to_d(output['price24low'])
          ticker.volume    = NumericHelper.to_d(output['volumeBase'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
