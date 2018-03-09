module Cryptoexchange::Exchanges
  module Idex
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          params = {}
          params['market'] = "#{market_pair.target}_#{market_pair.base}"
          output = fetch_using_post(ticker_url, params)
          adapt(filter_na_value(output), market_pair)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Idex::Market::API_URL}/returnTicker"
        end

        def filter_na_value(output)
          output.each do |k, v|
            output[k] = nil if v == "N/A"
          end
        end

        def adapt(output, market_pair)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Idex::Market::NAME
          ticker.ask       = NumericHelper.to_d(output['lowestAsk'])
          ticker.bid       = NumericHelper.to_d(output['highestBid'])
          ticker.last      = NumericHelper.to_d(output['last'])
          ticker.high      = NumericHelper.to_d(output['high'])
          ticker.low       = NumericHelper.to_d(output['low'])
          ticker.volume    = NumericHelper.to_d(output['quoteVolume'])
          ticker.timestamp = Time.now.to_i
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
