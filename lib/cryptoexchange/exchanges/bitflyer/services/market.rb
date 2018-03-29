module Cryptoexchange::Exchanges
  module Bitflyer
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Bitflyer::Market::API_URL}/ticker?product_code=#{market_pair.base}_#{market_pair.target}"
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Bitflyer::Market::NAME
          ticker.ask       = NumericHelper.to_d(output['best_ask'])
          ticker.bid       = NumericHelper.to_d(output['best_bid'])
          ticker.last      = NumericHelper.to_d(output['ltp'])
          ticker.volume    = NumericHelper.to_d(output['volume_by_product'])
          ticker.timestamp = Time.parse(output['timestamp']).to_i
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
