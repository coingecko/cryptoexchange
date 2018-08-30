module Cryptoexchange::Exchanges
  module Syex
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
          "#{Cryptoexchange::Exchanges::Syex::Market::API_URL}/selectCoinMarket?payCoinName=USDT"
        end

        def adapt_all(output)
          output['model'].map do |ticker|
            market_pair = Cryptoexchange::Models::MarketPair.new(
              base: ticker['defaultenname'],
              target: Syex::Market::TARGET_SYM,
              market: Syex::Market::NAME
            )
            adapt(ticker, market_pair)
          end
        end

        def adapt(output, market_pair)
          market = output

          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Syex::Market::NAME
          ticker.ask       = NumericHelper.to_d(market['sellprice'])
          ticker.bid       = NumericHelper.to_d(market['buyprice'])
          ticker.last      = NumericHelper.to_d(market['newclinchprice'])
          ticker.high      = NumericHelper.to_d(market['highprice'])
          ticker.low       = NumericHelper.to_d(market['lowprice'])
          ticker.volume    = NumericHelper.to_d(market['count24'])
          ticker.timestamp = nil
          ticker.payload   = market
          ticker
        end
      end
    end
  end
end
