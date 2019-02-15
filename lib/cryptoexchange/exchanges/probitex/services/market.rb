module Cryptoexchange::Exchanges
  module Probitex
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          output = super(self.ticker_url)
          adapt_all(output)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Probitex::Market::API_URL}/get_market_all"
        end

        def adapt_all(output)
          output['data'].map do |pair, ticker|
            adapt(pair, ticker)
          end
        end

        def adapt(pair, output)
          base, target     = pair.split('_')
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = base
          ticker.target    = target
          ticker.market    = Probitex::Market::NAME
          ticker.bid       = NumericHelper.to_d(output['buy_price'])
          ticker.ask       = NumericHelper.to_d(output['sell_price'])
          ticker.high      = NumericHelper.to_d(output['max_price'])
          ticker.low       = NumericHelper.to_d(output['min_price'])
          ticker.last      = NumericHelper.to_d(output['new_price'])
          ticker.volume    = NumericHelper.to_d(output['24h_num'])
          ticker.timestamp = nil
          ticker.payload   = [pair, output]
          ticker
        end
      end
    end
  end
end
