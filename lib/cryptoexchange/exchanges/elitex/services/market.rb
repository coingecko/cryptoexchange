module Cryptoexchange::Exchanges
  module Elitex
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
          "#{Cryptoexchange::Exchanges::Elitex::Market::API_URL}/public/#{market_pair.base.upcase}_#{market_pair.target.upcase}/ticker"
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Elitex::Market::NAME
          ticker.last      = NumericHelper.to_d(output['c'])
          ticker.high      = NumericHelper.to_d(output['h'])
          ticker.low       = NumericHelper.to_d(output['l'])
          ticker.volume    = NumericHelper.to_d(output['v'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
