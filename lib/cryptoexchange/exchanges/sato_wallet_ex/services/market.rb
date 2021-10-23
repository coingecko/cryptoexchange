module Cryptoexchange::Exchanges
  module SatoWalletEx
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
          "#{Cryptoexchange::Exchanges::SatoWalletEx::Market::API_URL}/Index/marketInfo"
        end

        def adapt_all(output)
          output["data"]["market"].map do |pair|
            base, target = pair["ticker"].split("_")

            market_pair = Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: SatoWalletEx::Market::NAME,
            )

            adapt(pair, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker = Cryptoexchange::Models::Ticker.new

          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = SatoWalletEx::Market::NAME
          ticker.last      = NumericHelper.to_d(output["new_price"])
          ticker.bid       = NumericHelper.to_d(output["buy_price"])
          ticker.ask       = NumericHelper.to_d(output["sell_price"])
          ticker.high      = NumericHelper.to_d(output["max_price"])
          ticker.low       = NumericHelper.to_d(output["min_price"])
          ticker.volume    = NumericHelper.to_d(output["volume"])
          ticker.change    = NumericHelper.to_d(output["change"])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
