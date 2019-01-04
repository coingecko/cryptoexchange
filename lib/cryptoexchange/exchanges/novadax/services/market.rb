module Cryptoexchange::Exchanges
  module Novadax
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(self.ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Novadax::Market::API_URL}/data/ticker?coin=#{market_pair.base}"
        end

        def adapt(output, market_pair)
          data_ticker = output['data']
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Novadax::Market::NAME
          ticker.last      = data_ticker['transType'] == 'SELL' ? NumericHelper.to_d(data_ticker['sell']) : NumericHelper.to_d(data_ticker['buy'])
          ticker.bid       = NumericHelper.to_d(data_ticker['buy'])
          ticker.ask       = NumericHelper.to_d(data_ticker['sell'])
          ticker.high      = NumericHelper.to_d(data_ticker['high'])
          ticker.low       = NumericHelper.to_d(data_ticker['low'])
          ticker.volume    = NumericHelper.to_d(data_ticker['vol'])
          ticker.timestamp = NumericHelper.to_d(data_ticker['date']) / 1000
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
