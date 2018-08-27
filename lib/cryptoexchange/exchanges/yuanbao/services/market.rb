module Cryptoexchange::Exchanges
  module Yuanbao
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
          "#{Cryptoexchange::Exchanges::Yuanbao::Market::API_URL}/#{market_pair.base.downcase}"
        end

        def adapt(output)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = output['name']
          ticker.target    = 'CNY'
          ticker.market    = Yuanbao::Market::NAME
          ticker.ask       = NumericHelper.to_d(output['sale'])
          ticker.bid       = NumericHelper.to_d(output['buy'])
          ticker.last      = NumericHelper.to_d(output['price'])
          ticker.high      = NumericHelper.to_d(output['max'])
          ticker.low       = NumericHelper.to_d(output['min'])
          ticker.volume    = NumericHelper.to_d(output['volume_24h'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
