module Cryptoexchange::Exchanges
  module CryTrex
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super ticker_url(market_pair)
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::CryTrex::Market::API_URL}/ticker?market=#{market_pair.base}_#{market_pair.target}"
        end

        def adapt(output, market_pair)
          output           = output.first[1]
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = CryTrex::Market::NAME
          ticker.bid       = NumericHelper.to_d(output['buy'])
          ticker.ask       = NumericHelper.to_d(output['sell'])
          ticker.last      = NumericHelper.to_d(output['last'])
          ticker.volume    = NumericHelper.to_d(output['vol'])
          ticker.high      = NumericHelper.to_d(output['high'])
          ticker.low       = NumericHelper.to_d(output['low'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
