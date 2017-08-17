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
          adapt(output)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Anx::Market::API_URL}/#{market_pair.base}#{market_pair.target}/money/ticker"
        end

        def adapt(output)
          ticker = Cryptoexchange::Models::Ticker.new
          base = output['data']['vol']['currency']
          target = output['data']['high']['currency']

          ticker.base      = base
          ticker.target    = target
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
