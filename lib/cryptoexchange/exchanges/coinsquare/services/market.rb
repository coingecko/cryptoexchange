module Cryptoexchange::Exchanges
  module Coinsquare
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
          "https://coinsquare.com/api/v1/data/quotes"
        end

        def adapt_all(output)
          output['quotes'].map do |pair|
            market_pair  = Cryptoexchange::Models::MarketPair.new(
              base: pair['ticker'],
              target: pair['base'],
              market: Coinsquare::Market::NAME
            )
            adapt(market_pair, pair)
          end
        end

        def adapt(market_pair, output)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Coinsquare::Market::NAME
          ticker.last      = NumericHelper.to_d(output['last'].to_f)
          ticker.high      = NumericHelper.to_d(output['high24'].to_f)
          ticker.low       = NumericHelper.to_d(output['low24'].to_f)
          ticker.bid       = NumericHelper.to_d(output['bid '].to_f)
          ticker.ask       = NumericHelper.to_d(output['ask'].to_f)
          ticker.volume    = NumericHelper.to_d(output['volbase'].to_f)
          ticker.timestamp = Time.now.to_i
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
