module Cryptoexchange::Exchanges
  module Cxihub
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
          "#{Cryptoexchange::Exchanges::Cxihub::Market::API_URL}/market/v1/ticker"
        end

        def adapt_all(output)
          output['data'].map do |ticker|
            target, base = ticker['market'].split('/')

            market_pair = Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Cxihub::Market::NAME
            )
            adapt(ticker, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Cxihub::Market::NAME
          ticker.last      = NumericHelper.to_d(output['rate'])
          ticker.ask       = NumericHelper.to_d(output['sell'])
          ticker.bid       = NumericHelper.to_d(output['buy'])
          ticker.change    = NumericHelper.to_d(output['changePercent'])
          ticker.volume    = NumericHelper.to_d(output['volume'])
          ticker.timestamp = Time.now.to_i
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
