module Cryptoexchange::Exchanges
  module Bitpaction
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
          "#{Cryptoexchange::Exchanges::Bitpaction::Market::API_URL}/trade/ticks"
        end

        def adapt_all(output)
          output['data'].map do |market|
            base, target = market['symbol'].split('-')
            market_pair  = Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Bitpaction::Market::NAME
            )
            adapt(market, market_pair)
          end
        end

        def adapt(output, market_pair)
          market           = output
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Bitpaction::Market::NAME
          ticker.last      = NumericHelper.to_d(market['close'])
          ticker.high      = NumericHelper.to_d(market['high'])
          ticker.low       = NumericHelper.to_d(market['low'])
          ticker.volume    = NumericHelper.to_d(market['total'])
          ticker.change    = NumericHelper.to_d(market['changeRange'])
          ticker.timestamp = Time.now.to_i
          ticker.payload   = market
          ticker
        end
      end
    end
  end
end
