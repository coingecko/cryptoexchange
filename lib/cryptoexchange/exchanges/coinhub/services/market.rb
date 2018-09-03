module Cryptoexchange::Exchanges
  module Coinhub
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          raw_output = HTTP.get(ticker_url)
          output = JSON.parse(raw_output)
          adapt_all(output)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Coinhub::Market::API_URL}/coinhub/public/returnTicker"
        end

        def adapt_all(output)
          output['results'].map do |pair|
            base, target = pair[0].split('-')
            market_pair  = Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Coinhub::Market::NAME
            )
            adapt(market_pair, pair[1])
          end
        end

        def adapt(market_pair, output)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Coinhub::Market::NAME
          ticker.last      = NumericHelper.to_d(output['last'].to_f)
          ticker.high      = NumericHelper.to_d(output['high24hr'].to_f)
          ticker.low       = NumericHelper.to_d(output['low24hr'].to_f)
          ticker.bid       = NumericHelper.to_d(output['highestBid'].to_f)
          ticker.ask       = NumericHelper.to_d(output['lowestAsk'].to_f)
          ticker.volume    = NumericHelper.to_d(output['volume24hr'].to_f)
          ticker.change    = NumericHelper.to_d(output['changePrice'].to_f)
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
