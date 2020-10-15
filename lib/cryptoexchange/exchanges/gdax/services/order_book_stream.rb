module Cryptoexchange::Exchanges
  module Gdax
    module Services
      class OrderBookStream < Cryptoexchange::Services::OrderBookStream
        def multiple_connections?
          false
        end

        def url
          Cryptoexchange::Exchanges::Gdax::Market::WS_URL
        end

        def valid_message?(message, market_pair)
          message['type'] == "snapshot" && message['product_id'] == "#{market_pair.base}-#{market_pair.target}"
        end

        def parse_message(message, market_pair)
          order_book           = Cryptoexchange::Models::OrderBook.new
          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Gdax::Market::NAME
          order_book.bids      = adapt_orders(message['bids'])
          order_book.asks      = adapt_orders(message['asks'])
          order_book.timestamp = Time.now.to_i
          order_book.payload   = message
          order_book
        end

        private

        def adapt_orders(message)
          message.collect do |order_entry|
            Cryptoexchange::Models::Order.new(price: NumericHelper.to_d(order_entry[0]),
                                              amount: NumericHelper.to_d(order_entry[1]),
                                              timestamp: nil)
          end
        end
      end
    end
  end
end
