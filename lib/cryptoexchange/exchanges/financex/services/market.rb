module Cryptoexchange::Exchanges
  module Financex
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          response = super(ticker_url)
          adapt_all(response)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Financex::Market::API_URL}"
        end

        def adapt_all(response)
          response.map do |ticker|
            target, base = ticker[0].split('_')
            market_pair = Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Financex::Market::NAME
            )
            adapt(ticker, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Financex::Market::NAME
          ticker.low       = NumericHelper.to_d(output[1]['Low24hr'])
          ticker.high      = NumericHelper.to_d(output[1]['High24hr'])
          ticker.last      = NumericHelper.to_d(output[1]['last'])
          ticker.bid       = NumericHelper.to_d(output[1]['highestBid'])
          ticker.ask       = NumericHelper.to_d(output[1]['lowestAsk'])
          ticker.volume    = NumericHelper.to_d(output[1]['BaseVolume'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
