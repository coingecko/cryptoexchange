module Cryptoexchange::Exchanges
  module Bitfinex
    module Services
      class TradeStream < Cryptoexchange::Services::TradeStream
        def url
          Cryptoexchange::Exchanges::Bitfinex::Market::WS_URL
        end

        def subscribe_event(market_pair)
          {
            event:   "subscribe",
            channel: "trades",
            pair:    "#{market_pair.base}#{market_pair.target}"
          }.to_json
        end

        def valid_message?(message)
          message.is_a?(Array) && message.length == 7
        end

        def parse_message(message, market_pair)
          # [ 5, 'te', '1234-BTCUSD', 1443659698, 236.42, 0.49064538 ]
          # [ 5, 'tu', '1234-BTCUSD', 15254529, 1443659698, 236.42, 0.49064538 ]
          # [67452,6614.9,36.37426215,6615,71.7470363,42.2,0.0064,6614.9,9981.07371415,6741.4366438,6570]
          #
          # CHANNEL_ID integer	Channel ID
          # SEQ	       string	  Trade sequence id
          # ID	       int	    Trade database id
          # TIMESTAMP	 int	    Unix timestamp of the trade.
          # PRICE	     float    Price at which the trade was executed
          # ±AMOUNT	   float    How much was bought (positive) or sold (negative)
          trade           = Cryptoexchange::Models::Trade.new
          trade.base      = market_pair.base
          trade.target    = market_pair.target
          trade.market    = Bitfinex::Market::NAME
          trade.trade_id  = message[3]
          trade.type      = message[6] > 0 ? 'buy' : 'sell' # The order that causes the trade determines if it is a buy or a sell.
          trade.price     = message[5]
          trade.amount    = message[6]
          trade.timestamp = message[4]
          trade.payload   = message

          trade
        end
      end
    end
  end
end
