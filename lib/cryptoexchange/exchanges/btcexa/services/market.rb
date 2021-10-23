module Cryptoexchange::Exchanges
  module Btcexa
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
          "#{Cryptoexchange::Exchanges::Btcexa::Market::API_URL}/market/ticker"
        end

        def adapt_all(output)
          output['result'].map do |output|
            base, target = output[0].split("_")
            market_pair = Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Btcexa::Market::NAME
            )
            adapt(output, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Btcexa::Market::NAME
          ticker.high      = NumericHelper.to_d(output[7])
          ticker.low       = NumericHelper.to_d(output[8])
          ticker.change    = NumericHelper.to_d(output[4])
          ticker.last      = NumericHelper.to_d(output[1])
          ticker.volume    = NumericHelper.to_d(output[5])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
