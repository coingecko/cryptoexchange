module Cryptoexchange::Exchanges
  module Chainex
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
          "#{Cryptoexchange::Exchanges::Chainex::Market::API_URL}/market/summary"
        end

        def adapt_all(output)
          pairs = output['data']
          pairs.map do |pair|
          market_pair  =  Cryptoexchange::Models::MarketPair.new(
              base: pair['code'],
              target: pair['exchange'],
              market: Chainex::Market::NAME
            )
          adapt(pair, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Chainex::Market::NAME
          ticker.ask       = NumericHelper.to_d(output['top_ask'])
          ticker.bid       = NumericHelper.to_d(output['top_bid'])
          ticker.low       = NumericHelper.to_d(output['24hlow'])
          ticker.high      = NumericHelper.to_d(output['24hhigh'])
          ticker.last      = NumericHelper.to_d(output['last_price'])
          ticker.volume    = NumericHelper.to_d(output['24hvol']) / NumericHelper.to_d(output['last_price'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
