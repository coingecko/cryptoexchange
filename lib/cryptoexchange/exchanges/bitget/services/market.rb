module Cryptoexchange::Exchanges
  module Bitget
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
          "#{Cryptoexchange::Exchanges::Bitget::Market::API_URL}/market/tickers"
        end

        def adapt_all(output)
          output["data"].map do |output|
            base, target = output["symbol"].split('_')
            market_pair = Cryptoexchange::Models::MarketPair.new(
              base: base.upcase,
              target: target.upcase,
              market: Bitget::Market::NAME
            )

            adapt(output, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Bitget::Market::NAME
          ticker.last      = NumericHelper.to_d(output['close'])
          ticker.volume    = NumericHelper.to_d(output['amount'])
          ticker.high      = NumericHelper.to_d(output['high'])
          ticker.low       = NumericHelper.to_d(output['low'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
