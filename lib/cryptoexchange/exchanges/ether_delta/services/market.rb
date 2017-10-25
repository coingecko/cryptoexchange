require 'bigdecimal'

module Cryptoexchange::Exchanges
  module EtherDelta
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
          "#{Cryptoexchange::Exchanges::EtherDelta::Market::API_URL}/returnTicker"
        end

        def adapt(output, market_pair)
          name = "#{market_pair.target}_#{market_pair.base}"
          market = output[name]
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = EtherDelta::Market::NAME
          ticker.last      = NumericHelper.to_d(market['last'].to_s)
          ticker.bid       = NumericHelper.to_d(market['bid'].to_s)
          ticker.ask       = NumericHelper.to_d(market['ask'].to_s)
          ticker.volume    = NumericHelper.to_d(market['quoteVolume'].to_s)
          ticker.timestamp = DateTime.now.to_time.to_i
          ticker.payload   = market
          ticker
        end
      end
    end
  end
end
