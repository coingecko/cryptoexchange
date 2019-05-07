module Cryptoexchange::Exchanges
  module Exrates
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
          "#{Cryptoexchange::Exchanges::Exrates::Market::API_URL}/ticker"
        end

        def adapt_all(output)
          output.map do |ticker|
            base, target = ticker["name"].split('_')
            market_pair = Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target, 
              market: Exrates::Market::NAME
            )
            adapt(ticker, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Exrates::Market::NAME
          ticker.ask       = NumericHelper.to_d(output['lowestAsk'])
          ticker.bid       = NumericHelper.to_d(output['highestBid'])
          ticker.change    = NumericHelper.to_d(output['percentChange'])
          ticker.last      = NumericHelper.to_d(output['last'])
          ticker.high      = NumericHelper.to_d(output['high'])
          ticker.low       = NumericHelper.to_d(output['low'])
          ticker.volume    = NumericHelper.to_d(output['baseVolume'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker  
        end
      end
    end
  end
end
