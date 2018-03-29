module Cryptoexchange::Exchanges
  module Anx
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
          "#{Cryptoexchange::Exchanges::Anx::Market::API_URL}/#{market_pair.base}#{market_pair.target}/money/ticker"
        end

        def adapt(output, market_pair)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Anx::Market::NAME
          ticker.ask       = NumericHelper.to_d(output['data']['sell']['value'])
          ticker.bid       = NumericHelper.to_d(output['data']['buy']['value'])
          ticker.last      = NumericHelper.to_d(output['data']['last']['value'])
          ticker.high      = NumericHelper.to_d(output['data']['high']['value'])
          ticker.low       = NumericHelper.to_d(output['data']['low']['value'])
          ticker.volume    = NumericHelper.to_d(output['data']['vol']['value'])
          ticker.timestamp = output['data']['dataUpdateTime'].to_i / 1000000
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
