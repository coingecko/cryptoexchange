module Cryptoexchange::Exchanges
  module Bitsoda
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
          "#{Cryptoexchange::Exchanges::Bitsoda::Market::API_URL}/market/prices"
        end

        def adapt_all(output)
          output["data"].map do |pair, ticker|
            base, target = pair.split("_")
            market_pair = Cryptoexchange::Models::MarketPair.new(
                            base: base,
                            target: target,
                            market: Bitsoda::Market::NAME
                          )

            adapt(ticker, market_pair)
          end
        end

        def adapt(output, market_pair)
          array = output.delete('[]').split(",")
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = Bitsoda::Market::NAME
          ticker.last = NumericHelper.to_d(array[4])
          ticker.high = NumericHelper.to_d(array[2])
          ticker.low = NumericHelper.to_d(array[3])
          ticker.volume = NumericHelper.to_d(array[5])
          ticker.timestamp = nil
          ticker.payload = array
          ticker
        end
      end
    end
  end
end
