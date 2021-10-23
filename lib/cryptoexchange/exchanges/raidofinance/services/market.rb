module Cryptoexchange::Exchanges
  module Raidofinance
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output["data"], market_pair)
        end

        def ticker_url(market_pair)
          base = market_pair.base.upcase
          target = market_pair.target.upcase
          "#{Cryptoexchange::Exchanges::Raidofinance::Market::API_URL}/ticker/#{base}#{target}"
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Raidofinance::Market::NAME
          ticker.ask       = NumericHelper.to_d(output['ask'])
          ticker.bid       = NumericHelper.to_d(output['bid'])
          ticker.last      = NumericHelper.to_d(output['last'])
          ticker.high      = NumericHelper.to_d(output['high'])
          ticker.low       = NumericHelper.to_d(output['low'])
          ticker.volume    = NumericHelper.to_d(output['volume24'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
