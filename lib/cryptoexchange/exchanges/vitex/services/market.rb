module Cryptoexchange::Exchanges
  module Vitex
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          output = super ticker_url
          adapt_all output
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Vitex::Market::API_URL}/ticker/24hr"
        end

        def adapt_all(output)
          output["data"].map do |ticker|
            market_pair = Cryptoexchange::Models::MarketPair.new(
              base:   ticker["tradeTokenSymbol"],
              target: ticker["quoteTokenSymbol"],
              market: Vitex::Market::NAME
            )

            adapt(ticker, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Vitex::Market::NAME
          ticker.last      = NumericHelper.to_d(output['closePrice'])
          ticker.volume    = NumericHelper.to_d(output['quantity'])
          ticker.change    = NumericHelper.to_d(output['priceChange'])
          ticker.low       = NumericHelper.to_d(output['lowPrice'])
          ticker.high      = NumericHelper.to_d(output['highPrice'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
