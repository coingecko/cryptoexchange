module Cryptoexchange::Exchanges
  module Remitano
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          output = super(ticker_url)
          adapt_all(output)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Remitano::Market::API_URL}/volumes/market_summaries"
        end

        def adapt_all(output)
          output.map do |key, data|
            adapt(data)
          end
        end

        def adapt(data)
          ticker = Cryptoexchange::Models::Ticker.new

          ticker.base      = data["currency1"]
          ticker.target    = data["currency2"]
          ticker.market    = Remitano::Market::NAME
          ticker.last      = NumericHelper.to_d(data['last'])
          ticker.high      = NumericHelper.to_d(data['high_price'])
          ticker.low       = NumericHelper.to_d(data['low_price'])
          ticker.ask       = NumericHelper.to_d(data['lowest_ask'])
          ticker.bid       = NumericHelper.to_d(data['highest_bid'])
          ticker.volume    = NumericHelper.to_d(data['volume24h'])
          ticker.timestamp = nil
          ticker.payload   = data
          ticker
        end
      end
    end
  end
end
