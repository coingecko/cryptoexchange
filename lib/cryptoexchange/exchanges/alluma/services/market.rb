module Cryptoexchange::Exchanges
  module Alluma
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
          "#{Cryptoexchange::Exchanges::Alluma::Market::API_URL}/server/misc/all_ticker"
        end

        def adapt_all(output)
          output['data'].map do |ticker|
            market_pair = Cryptoexchange::Models::MarketPair.new(
              base:   ticker['target'],
              target: ticker['base'],
              market: Alluma::Market::NAME
            )
            adapt(market_pair, ticker)
          end
        end

        def adapt(market_pair, output)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Alluma::Market::NAME
          ticker.last      = NumericHelper.to_d(output['SessionClose'])
          ticker.high      = NumericHelper.to_d(output['SessionHigh'])
          ticker.low       = NumericHelper.to_d(output['SessionLow'])
          ticker.bid       = NumericHelper.to_d(output['BestBid'])
          ticker.ask       = NumericHelper.to_d(output['BestOffer'])
          ticker.volume    = NumericHelper.to_d(output['Rolling24HrVolume'])
          ticker.change    = NumericHelper.to_d(output['Rolling24HrPxChange'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
