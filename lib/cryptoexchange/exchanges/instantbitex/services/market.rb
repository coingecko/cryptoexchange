module Cryptoexchange::Exchanges
  module Instantbitex
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          output = super(ticker_url)
          adapt_all(output['combinations'])
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Instantbitex::Market::API_URL}/tickers"
        end

        def adapt_all(output)
          output.map do |ticker|
            base, target = ticker[0].split('_')
            market_pair = Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Instantbitex::Market::NAME
            )
            adapt(ticker[1], market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Instantbitex::Market::NAME
          ticker.last      = NumericHelper.to_d(output['last'].to_f)
          ticker.change    = NumericHelper.to_d(output['change24hr'].to_f)
          ticker.bid       = NumericHelper.to_d(output['lowestAsk'].to_f)
          ticker.ask       = NumericHelper.to_d(output['highestBid'].to_f) # ask is higher
          ticker.high      = NumericHelper.to_d(output['high24hr'].to_f)
          ticker.low       = NumericHelper.to_d(output['low24hr'].to_f)
          ticker.volume    = NumericHelper.divide(NumericHelper.to_d(output['volume24hr'].to_f), ticker.last)
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
