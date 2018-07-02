module Cryptoexchange::Exchanges
  module Idax
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
          "#{Cryptoexchange::Exchanges::Idax::Market::API_URL}/GetAllOpenMarkets"
        end

        def adapt_all(output)
          output['data'].map do |pair|
            market_pair = Cryptoexchange::Models::MarketPair.new(
              base: pair['baseCode'],
              target: pair['quoteCode'], 
              market: Idax::Market::NAME
            )
            adapt(market_pair, pair)
          end
        end

        def adapt(market_pair, output)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Idax::Market::NAME
          ticker.change    = NumericHelper.to_d(output['change'])
          ticker.last      = NumericHelper.to_d(output['lastPrice'])
          ticker.high      = NumericHelper.to_d(output['high'])
          ticker.low       = NumericHelper.to_d(output['low'])
          ticker.volume    = NumericHelper.to_d(output['volume'])
          ticker.timestamp = Time.now.to_i
          ticker.payload   = output
          ticker  
        end
      end
    end
  end
end
