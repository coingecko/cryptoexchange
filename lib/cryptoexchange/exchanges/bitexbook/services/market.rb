module Cryptoexchange::Exchanges
  module Bitexbook
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
          "#{Cryptoexchange::Exchanges::Bitexbook::Market::API_URL}/symbols/statistic?last_day=true"
        end

        def adapt_all(output)
          output['symbols'].map { |market_data| adapt(market_data) }.compact
        end

        def adapt(market_data)
          base, target     = market_data['alias'].split('/')
          data = market_data['statistic'].first
          return if data.nil?

          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = base
          ticker.target    = target
          ticker.market    = Bitexbook::Market::NAME
          ticker.ask       = NumericHelper.to_d(data['price_ask'])
          ticker.bid       = NumericHelper.to_d(data['price_bid'])
          ticker.last      = NumericHelper.to_d(data['price_close'])
          ticker.high      = NumericHelper.to_d(data['price_high'])
          ticker.low       = NumericHelper.to_d(data['price_low'])
          ticker.volume    = NumericHelper.to_d(data['volume_base'])
          ticker.timestamp = nil
          ticker.payload   = market_data
          ticker
        end
      end
    end
  end
end
