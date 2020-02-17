module Cryptoexchange::Exchanges
  module Currency
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          output = super ticker_url
          adapt_all(output)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Currency::Market::API_URL}/api/v1/ticker"
        end

        def adapt_all(output)
          output.map do |pair, ticker|
            adapt(pair, ticker)
          end
        end

        def adapt(pair, output)
            base, target     = pair.split('/')
            ticker           = Cryptoexchange::Models::Ticker.new
            ticker.base      = base
            ticker.target    = target
            ticker.ask       = NumericHelper.to_d(output['lowest_ask_price'])
            ticker.bid       = NumericHelper.to_d(output['highest_bid_price'])
            ticker.last      = NumericHelper.to_d(output['last_price'])
            ticker.high      = NumericHelper.to_d(output['past_24hrs_high_price'])
            ticker.low       = NumericHelper.to_d(output['past_24hrs_low_price'])
            ticker.change    = NumericHelper.to_d(output['past_24hrs_price_change'].to_f)
            ticker.volume    = NumericHelper.to_d(output['base_volume'])
            ticker.timestamp = nil
            ticker.payload   = output
            ticker
        end
      end
    end
  end
end
