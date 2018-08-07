module Cryptoexchange::Exchanges
  module Instantbitex
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(market_pair, output['combinations'])
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Instantbitex::Market::API_URL}/customticker/#{market_pair.base}_#{market_pair.target}"
        end

        def adapt(market_pair, output)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Instantbitex::Market::NAME
          ticker.last      = NumericHelper.to_d(output['last'].to_f)
          ticker.change    = NumericHelper.to_d(output['change24hr'].to_f)
          ticker.bid       = NumericHelper.to_d(output['highestBid'].to_f)
          ticker.ask       = NumericHelper.to_d(output['lowestAsk'].to_f)
          ticker.high      = NumericHelper.to_d(output['high24hr'].to_f)
          ticker.low       = NumericHelper.to_d(output['low24hr'].to_f)
          ticker.volume    = NumericHelper.to_d(output['volume24hr'].to_f)
          ticker.timestamp = Time.now.to_i
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
