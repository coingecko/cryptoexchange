module Cryptoexchange::Exchanges
  module Coinex
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
          "#{Cryptoexchange::Exchanges::Coinex::Market::API_URL}/market/ticker/all"
        end

        def adapt_all(output)
          timestamp = output['data']['date'] / 1000
          output['data']['ticker'].map do |pair, market|
            separator = /(USDT|BTC|BCH)\z/ =~ pair
            base = pair[0..separator - 1]
            target = pair[separator..-1]
            market_pair = Cryptoexchange::Models::MarketPair.new(
                           base: base,
                           target: target,
                           market: Coinex::Market::NAME
                         )
            adapt(market, market_pair, timestamp)
          end
        end

        def adapt(output, market_pair, timestamp)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Coinex::Market::NAME
          ticker.ask       = NumericHelper.to_d(output['sell'])
          ticker.bid       = NumericHelper.to_d(output['buy'])
          ticker.last      = NumericHelper.to_d(output['last'])
          ticker.high      = NumericHelper.to_d(output['high'])
          ticker.low       = NumericHelper.to_d(output['low'])
          ticker.volume    = NumericHelper.to_d(output['vol'])
          ticker.timestamp = timestamp
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
