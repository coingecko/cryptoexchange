module Cryptoexchange::Exchanges
  module Velic
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
          "#{Cryptoexchange::Exchanges::Velic::Market::API_URL}/public/ticker"
        end

        def adapt_all(output)
          output.map do |ticker|
            target      = ticker['baseCoin']
            base        = ticker['mtchCoin']
            market_pair = Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Velic::Market::NAME
            )
            adapt(ticker, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Velic::Market::NAME
          
          ticker.last      = NumericHelper.to_d(output['recPrice'])
          ticker.high      = NumericHelper.to_d(output['highPrice'])
          ticker.low       = NumericHelper.to_d(output['lowPrice'])
          ticker.volume    = NumericHelper.to_d(output['matchCurrcyVol'])
          ticker.change    = NumericHelper.to_d(output['chngRate'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
