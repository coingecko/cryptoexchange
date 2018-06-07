module Cryptoexchange::Exchanges
  module Nebula
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
          "#{Cryptoexchange::Exchanges::Nebula::Market::API_URL}/v1/exchanges"
        end

        def adapt_all(output)
          output.map do |ticker|
            base, target = ticker['symbol'].split('_')
            market_pair  = Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Nebula::Market::NAME
            )
            adapt(ticker, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Nebula::Market::NAME
          ticker.last      = NumericHelper.to_d(output['lastPrice'])
          ticker.high      = NumericHelper.to_d(output['highPrice'])
          ticker.low       = NumericHelper.to_d(output['lowPrice'])
          ticker.change    = NumericHelper.to_d(output['change'])
          ticker.volume    = NumericHelper.divide(NumericHelper.to_d(output['volume']), ticker.last)
          ticker.timestamp = Time.now.to_i
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
