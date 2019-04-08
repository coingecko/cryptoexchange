module Cryptoexchange::Exchanges
  module Koinx
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          output = Cryptoexchange::Cache.ticker_cache.fetch(ticker_url) do
            HTTP.timeout(15).headers(accept: 'application/json').follow.get(ticker_url).parse(:json)
          end
          adapt_all(output)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Koinx::Market::API_URL}/tickers"
        end

        def adapt_all(output)
          output.map do |output|
            if output[0].include?("/")
              base, target = output[0].split("/")
              market_pair = Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              market: Koinx::Market::NAME
                            )
              adapt(market_pair, output[1])
            end
          end.compact
        end

        def adapt(market_pair, output)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Koinx::Market::NAME

          ticker.last      = NumericHelper.to_d(output["last_price"])
          ticker.bid       = NumericHelper.to_d(output["highest_bid_price"])
          ticker.ask       = NumericHelper.to_d(output["lowest_ask_price"])
          ticker.high      = NumericHelper.to_d(output["past_24hrs_high_price"])
          ticker.low       = NumericHelper.to_d(output["past_24hrs_low_price"])
          ticker.change    = NumericHelper.to_d(output["past_24hrs_price_change"])
          ticker.volume    = NumericHelper.to_d(output["past_24hrs_base_volume"])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
