module Cryptoexchange::Exchanges
  module Coinhe
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
          "#{Cryptoexchange::Exchanges::Coinhe::Market::API_URL}/currency-pair-summary?page_size=150"
        end

        def adapt_all(output)
          output["results"].map do |ticker|
            # begin
              target = ticker["base"]["symbol"]
              base = ticker["pair"]["symbol"]

              market_pair = Cryptoexchange::Models::MarketPair.new(
                base:   base,
                target: target,
                market: Coinhe::Market::NAME
              )
              adapt(ticker, market_pair)

            # rescue StandardError
              # nil
            # end
          end.compact
        end

        def adapt(output, market_pair)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Coinhe::Market::NAME

          inversed_volume = NumericHelper.to_d(output["volume_24h"])

          ticker.last      = NumericHelper.to_d(output["last_price"])
          ticker.high      = NumericHelper.to_d(output["high_24h"])
          ticker.low       = NumericHelper.to_d(output["low_24h"])
          ticker.volume    = NumericHelper.flip_volume(inversed_volume, ticker.last)
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
