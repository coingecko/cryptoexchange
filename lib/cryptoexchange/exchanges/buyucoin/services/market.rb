module Cryptoexchange::Exchanges
  module Buyucoin
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
          "#{Cryptoexchange::Exchanges::Buyucoin::Market::API_URL}/currency/markets"
        end

        def adapt_all(output)
          output['data'].map do |pair, ticker|
            base, target = pair.split('_')
            market_pair = Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Buyucoin::Market::NAME
            )
            adapt(ticker, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Buyucoin::Market::NAME
          ticker.ask       = NumericHelper.to_d(output['ask'])
          ticker.bid       = NumericHelper.to_d(output['bid'])
          ticker.high      = NumericHelper.to_d(output['high_24'])
          ticker.low       = NumericHelper.to_d(output['low_24'])
          ticker.change    = NumericHelper.to_d(output['change'])
          ticker.last      = NumericHelper.to_d(output['last_trade'])
          ticker.volume    = NumericHelper.to_d(output['vol'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
