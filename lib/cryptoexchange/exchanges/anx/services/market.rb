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

          ticker.base      = base
          ticker.target    = target
          ticker.market    = Anx::Market::NAME
          ticker.ask       = output['data']['sell']['value'] ? BigDecimal.new(output['data']['sell']['value'].to_s) : nil
          ticker.bid       = output['data']['buy']['value'] ? BigDecimal.new(output['data']['buy']['value'].to_s) : nil
          ticker.last      = output['data']['last']['value'] ? BigDecimal.new(output['data']['last']['value'].to_s) : nil
          ticker.high      = output['data']['high']['value'] ? BigDecimal.new(output['data']['high']['value'].to_s) : nil
          ticker.low       = output['data']['low']['value'] ? BigDecimal.new(output['data']['low']['value'].to_s) : nil
          ticker.volume    = output['data']['vol']['value'] ? BigDecimal.new(output['data']['vol']['value'].to_s) : nil
          ticker.timestamp = output['data']['dataUpdateTime'].to_i
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
