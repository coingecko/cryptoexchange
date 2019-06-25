module Cryptoexchange::Exchanges
  module Uex
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          symbol = "#{market_pair.base.downcase}#{market_pair.target.downcase}"
          output = super(ticker_url(symbol))
          adapt(market_pair, output)
        end

        def ticker_url(symbol)
          "#{Cryptoexchange::Exchanges::Uex::Market::API_URL}/open/api/get_ticker?symbol=#{symbol}"
        end

        def adapt(market_pair, output)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Uex::Market::NAME
          ticker.last      = NumericHelper.to_d(output['data']['last'])
          ticker.bid       = NumericHelper.to_d(output['data']['buy'])
          ticker.ask       = NumericHelper.to_d(output['data']['sell'])
          ticker.high      = NumericHelper.to_d(output['data']['high'])
          ticker.low       = NumericHelper.to_d(output['data']['low'])
          ticker.volume    = NumericHelper.to_d(output['data']['vol'])
          ticker.timestamp = nil
          ticker.payload   = output

          ticker
        end
      end
    end
  end
end
