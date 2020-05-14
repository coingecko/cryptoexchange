module Cryptoexchange::Exchanges
  module FtxUs
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
          "#{Cryptoexchange::Exchanges::FtxUs::Market::API_URL}/markets/#{market_pair.base}/#{market_pair.target}"
        end

        def adapt(output, market_pair)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = FtxUs::Market::NAME
          ticker.ask = NumericHelper.to_d(output["ask"])
          ticker.bid = NumericHelper.to_d(output["bid"])
          ticker.last = NumericHelper.to_d(output["price"])
          ticker.volume = NumericHelper.divide(NumericHelper.to_d(output["quoteVolume24h"]), ticker.last)
          ticker.timestamp = nil
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
