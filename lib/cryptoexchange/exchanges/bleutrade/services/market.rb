module Cryptoexchange::Exchanges
  module Bleutrade
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
          "#{Cryptoexchange::Exchanges::Bleutrade::Market::API_URL}/public/getmarketsummaries"
        end

        def adapt_all(output)
          output['result'].map do |ticker|
            base, target = ticker['MarketName'].split("_")
            market_pair = Cryptoexchange::Models::MarketPair.new(
                          base: base,
                          target: target,
                          market: Bleutrade::Market::NAME
                        )
            adapt(ticker, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Bleutrade::Market::NAME
          ticker.ask       = NumericHelper.to_d(output['Ask'])
          ticker.bid       = NumericHelper.to_d(output['Bid'])
          ticker.last      = NumericHelper.to_d(output['Last'])
          ticker.high      = NumericHelper.to_d(output['High'])
          ticker.low       = NumericHelper.to_d(output['Low'])
          ticker.volume    = NumericHelper.to_d(output['Volume'])
          ticker.timestamp = output['TimeStamp'].empty? ? nil : Time.parse(output['TimeStamp']).to_i
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
