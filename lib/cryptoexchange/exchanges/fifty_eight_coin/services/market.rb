module Cryptoexchange::Exchanges
  module FiftyEightCoin
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
          "#{Cryptoexchange::Exchanges::FiftyEightCoin::Market::API_URL}/spot/ticker"
        end

        def adapt_all(response)
          response['result'].map do |record|
            base, target = record['symbol'].split('_')
            market_pair = Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: FiftyEightCoin::Market::NAME
            )
            adapt(record, market_pair)
          end
        end

        def adapt(record, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = FiftyEightCoin::Market::NAME
          ticker.low       = NumericHelper.to_d(record['low'])
          ticker.high      = NumericHelper.to_d(record['high'])
          ticker.last      = NumericHelper.to_d(record['last'])
          ticker.bid       = NumericHelper.to_d(record['bid'])
          ticker.ask       = NumericHelper.to_d(record['ask'])         
          ticker.volume    = NumericHelper.to_d(record['volume'])
          ticker.timestamp = nil
          ticker.payload   = record
          ticker
        end
      end
    end
  end
end
