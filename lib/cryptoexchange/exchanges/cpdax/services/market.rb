module Cryptoexchange::Exchanges
  module Cpdax
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
          base = market_pair.base
          target = market_pair.target
          "#{Cryptoexchange::Exchanges::Cpdax::Market::API_URL}/ticker/#{base}-#{target}/detailed"
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = market_pair.market

          ticker.last      = NumericHelper.to_d(output['data']['ticker']['last'])
          ticker.bid       = NumericHelper.to_d(output['data']['ticker']['bid'])
          ticker.ask       = NumericHelper.to_d(output['data']['ticker']['ask'])
          ticker.low       = NumericHelper.to_d(output['data']['ticker']['low'])
          ticker.high      = NumericHelper.to_d(output['data']['ticker']['high'])
          ticker.volume    = NumericHelper.to_d(output['data']['ticker']['volume'])

          ticker.timestamp = output['data']['ticker']['timestamp'].to_i / 1000
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
