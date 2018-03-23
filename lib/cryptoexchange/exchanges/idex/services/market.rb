module Cryptoexchange::Exchanges
  module Idex
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          output = fetch_using_post(ticker_url, {})
          adapt_all(output)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Idex::Market::API_URL}/returnTicker"
        end

        def adapt_all(output)
          total = output.map do |key, value|
            target, base = key.split("_")
            market_pair = Cryptoexchange::Models::MarketPair.new(
                            base: base,
                            target: target,
                            market: Idex::Market::NAME
                          )
            adapt(value, market_pair)
          end.compact
        end

        def adapt(output, market_pair)
          if output['last'] == 'N/A'
            return nil
          end

          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Cryptoexchange::Exchanges::Idex::Market::NAME
          ticker.ask       = NumericHelper.to_d(na_to_nil(output['lowestAsk']))
          ticker.bid       = NumericHelper.to_d(na_to_nil(output['highestBid']))
          ticker.last      = NumericHelper.to_d(na_to_nil(output['last']))
          ticker.high      = NumericHelper.to_d(na_to_nil(output['high']))
          ticker.low       = NumericHelper.to_d(na_to_nil(output['low']))
          ticker.volume    = NumericHelper.to_d(na_to_nil(output['quoteVolume']))
          ticker.timestamp = Time.now.to_i
          ticker.payload   = output
          ticker
        end

        def na_to_nil(value)
          if value == 'N/A'
            nil
          else
            value
          end
        end
      end
    end
  end
end
