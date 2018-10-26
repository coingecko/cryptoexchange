module Cryptoexchange::Exchanges
  module Vaultmex
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          output = super(ticker_url)
          adapt_all(output)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Vaultmex::Market::API_URL}/market/summary"
        end

        def adapt_all(output)
          output.map do |ticker|
            market_pair = Cryptoexchange::Models::MarketPair.new(
              base:   ticker['code'],
              target: ticker['exchange'],
              market: Vaultmex::Market::NAME
            )
            adapt(ticker, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Vaultmex::Market::NAME
          ticker.bid       = NumericHelper.to_d(output['top_bid'])
          ticker.ask       = NumericHelper.to_d(output['top_ask'])
          ticker.last      = NumericHelper.to_d(output['last_price'])
          ticker.high      = NumericHelper.to_d(output['24hhigh'])
          ticker.low       = NumericHelper.to_d(output['24hlow'])
          ticker.volume    = NumericHelper.to_d(output['24hvol'])
          ticker.change    = NumericHelper.to_d(output['change'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
