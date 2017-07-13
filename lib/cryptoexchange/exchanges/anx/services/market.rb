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
          ticker = Anx::Models::Ticker.new
          base = output['data']['vol']['currency']
          target = output['data']['high']['currency']

          ticker.base = base
          ticker.target = target
          ticker.market = Anx::Market::NAME
          ticker.ask = output['data']['sell']['value']
          ticker.bid = output['data']['buy']['value']
          ticker.last = output['data']['last']['value']
          ticker.high = output['data']['high']['value']
          ticker.low = output['data']['low']['value']
          ticker.volume = output['data']['vol']['value']
          ticker.timestamp = output['data']['dataUpdateTime']
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
