module Cryptoexchange::Exchanges
  module Bitbay
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
          base = market_pair.base.downcase
          target = market_pair.target.downcase
          "#{Cryptoexchange::Exchanges::Bitbay::Market::API_URL}/#{base}#{target}/all.json"
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Bitbay::Market::NAME
          ticker.bid       = NumericHelper.to_d(output['bid'])
          ticker.ask       = NumericHelper.to_d(output['ask'])
          ticker.last      = NumericHelper.to_d(output['last'])
          ticker.high      = NumericHelper.to_d(output['max'])
          ticker.low       = NumericHelper.to_d(output['min'])
          ticker.volume    = NumericHelper.to_d(output["volume"])
          ticker.timestamp = NumericHelper.to_d(output["transactions"].first["date"])
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
