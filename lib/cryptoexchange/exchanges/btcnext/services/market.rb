module Cryptoexchange::Exchanges
  module Btcnext
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
          "#{Cryptoexchange::Exchanges::Btcnext::Market::API_URL}/ticker"
        end

        def adapt_all(output)
          output.map do |pair, ticker|
            base, target = pair.split("_")

            market_pair = Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Btcnext::Market::NAME
            )

            adapt(ticker, market_pair)
          end.compact
        end

        def adapt(output, market_pair)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = Btcnext::Market::NAME
          ticker.last = NumericHelper.to_d(output['last_price'])
          ticker.volume = NumericHelper.to_d(output['base_volume'])
          ticker.timestamp = nil
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
