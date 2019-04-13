module Cryptoexchange::Exchanges
  module Bitfinex
    module Services
      class OrderBookStream < Cryptoexchange::Services::OrderBookStream
        def url
          Cryptoexchange::Exchanges::Bitfinex::Market::WS_URL
        end

        def subscribe_event(market_pair)
          {
            event:   "subscribe",
            channel: "book",
            pair:    "#{market_pair.base}#{market_pair.target}"
          }.to_json
        end

        def valid_message?(message)
          message.is_a?(Array) && message.length == 4
        end

        def parse_message(message, market_pair)
          # CHANNEL_ID integer	Channel ID
          # PRICE	     float    Price level
          # COUNT      int      Number of orders at that price level
          # ±AMOUNT	   float    Total amount available at that price level. Positive values mean bid, negative values mean ask.
          order_book        = Cryptoexchange::Models::OrderBook.new
          order_book.base   = market_pair.base
          order_book.target = market_pair.target
          order_book.market = Bitfinex::Market::NAME

          if message[3] > 0
            order_book.bids = adapt_orders(message)
          else
            order_book.asks = adapt_orders(message)
          end

          order_book.timestamp = Time.now.to_i
          order_book.payload   = message
          order_book
        end

        private

        def adapt_orders(message)
          [
            Cryptoexchange::Models::Order.new(
              price: message[1],
              amount: message[3].abs,
              timestamp: nil
            )
          ]
        end
      end
    end
  end
end
