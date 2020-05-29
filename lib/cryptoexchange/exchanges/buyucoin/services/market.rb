module Cryptoexchange::Exchanges
  module Buyucoin
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output['data'][0], market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Buyucoin::Market::API_URL}/liveData?symbol=#{market_pair.target}-#{market_pair.base}"
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Buyucoin::Market::NAME
          ticker.ask       = NumericHelper.to_d(output['ask'])
          ticker.bid       = NumericHelper.to_d(output['bid'])
          ticker.high      = NumericHelper.to_d(output['h24'])
          ticker.low       = NumericHelper.to_d(output['l24'])
          ticker.change    = NumericHelper.to_d(output['c24'])
          ticker.last      = NumericHelper.to_d(output['LTRate'])
          ticker.volume    = NumericHelper.to_d(output['LBVol'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
