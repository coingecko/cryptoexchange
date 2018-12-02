module Cryptoexchange::Exchanges
  module Openbit
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
          "#{Cryptoexchange::Exchanges::Openbit::Market::API_URL}/Mapi/Index/marketInfo"
        end

        def adapt_all(output)
          output['data']['market'].map do |pair|
            raw_pair = pair['name'].match(/(\(.*)\)/).to_s
            base, target = raw_pair.delete('()').split('/')
            next unless base && target
            market_pair  = Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Openbit::Market::NAME
            )
            adapt(market_pair, pair)
          end
        end

        def adapt(market_pair, output)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Openbit::Market::NAME
          ticker.last      = NumericHelper.to_d(output['new_price'])
          ticker.high      = NumericHelper.to_d(output['max_price'])
          ticker.low       = NumericHelper.to_d(output['min_price'])
          ticker.bid       = NumericHelper.to_d(output['buy_price'])
          ticker.ask       = NumericHelper.to_d(output['sell_price'])
          ticker.volume    = NumericHelper.to_d(output['volume'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
