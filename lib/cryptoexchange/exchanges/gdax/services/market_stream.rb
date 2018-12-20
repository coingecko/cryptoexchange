module Cryptoexchange::Exchanges
  module Gdax
    module Services
      class MarketStream < Cryptoexchange::Services::MarketStream
        def multiple_connections?
          false
        end

        def url
          Cryptoexchange::Exchanges::Gdax::Market::WS_URL
        end

        def valid_message?(message, market_pair)
          message['type'] == "ticker" && message['product_id'] == "#{market_pair.base}-#{market_pair.target}" 
        end

        def parse_message(message, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Gdax::Market::NAME
          ticker.ask       = NumericHelper.to_d(message['best_ask'])
          ticker.bid       = NumericHelper.to_d(message['best_bid'])
          ticker.last      = NumericHelper.to_d(message['price'])
          ticker.high      = NumericHelper.to_d(message['high_24h'])
          ticker.low       = NumericHelper.to_d(message['low_24h'])
          ticker.volume    = NumericHelper.to_d(message['volume_24h'])
          ticker.timestamp = nil
          ticker.payload   = message
          ticker
        end
      end
    end
  end
end
