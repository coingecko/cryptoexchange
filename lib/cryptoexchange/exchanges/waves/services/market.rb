module Cryptoexchange::Exchanges
  module Waves
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
          "#{Cryptoexchange::Exchanges::Waves::Market::API_URL}/pairs"
        end

        def adapt_all(output)
          # fetch token symbol list first
          symbols = Cryptoexchange::Exchanges::Waves::Market.fetch_symbol
          output["data"].map do |ticker|
            base     = symbols[ticker['amountAsset']]
            target   = symbols[ticker['priceAsset']] || "WAVES"
            market_pair = Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Waves::Market::NAME
            )
            adapt(ticker, market_pair)
          end
        end

        def adapt(output, market_pair)
          data = output["data"]
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Waves::Market::NAME
          ticker.last      = NumericHelper.to_d(data['lastPrice'])
          ticker.volume    = NumericHelper.to_d(data['volume'])
          ticker.low       = NumericHelper.to_d(data['low'])
          ticker.high      = NumericHelper.to_d(data['high'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
