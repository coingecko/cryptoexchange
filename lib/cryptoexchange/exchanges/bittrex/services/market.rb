module Cryptoexchange::Exchanges
  module Bittrex
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
          "#{Cryptoexchange::Exchanges::Bittrex::Market::API_URL}/public/getmarketsummaries"
        end

        def adapt_all(output)
          output["result"].map do |data|
            adapt(data)
          end
        end

        def adapt(data)
          ticker = Cryptoexchange::Models::Ticker.new
          target, base = data["MarketName"].split("-")

          ticker.base      = base
          ticker.target    = target
          ticker.market    = Bittrex::Market::NAME
          ticker.last      = NumericHelper.to_d(data['Last'])
          ticker.high      = NumericHelper.to_d(data['High'])
          ticker.low       = NumericHelper.to_d(data['Low'])
          ticker.ask       = NumericHelper.to_d(data['Ask'])
          ticker.bid       = NumericHelper.to_d(data['Bid'])
          ticker.volume    = NumericHelper.to_d(data['Volume'])
          ticker.timestamp = nil
          ticker.payload   = data
          ticker
        end
      end
    end
  end
end
