module Cryptoexchange::Exchanges
  module Ftx
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end
      
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output["result"], market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Ftx::Market::API_URL}/futures/#{market_pair.inst_id}"
        end

        def adapt(output, market_pair)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = Ftx::Market::NAME
          ticker.inst_id = market_pair.inst_id
          ticker.ask = NumericHelper.to_d(output["ask"])
          ticker.bid = NumericHelper.to_d(output["bid"])
          ticker.last = NumericHelper.to_d(output["last"])
          ticker.volume = NumericHelper.divide(NumericHelper.to_d(output["volumeUsd24h"]), ticker.last)
          ticker.timestamp = nil
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
