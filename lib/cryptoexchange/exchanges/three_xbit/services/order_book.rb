module Cryptoexchange::Exchanges
  module ThreeXbit
    module Services
      class OrderBook < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(order_book_url(market_pair))
          adapt(output, market_pair)
        end

        def order_book_url(market_pair)
          base   = market_pair.base.downcase
          target = market_pair.target.downcase
          "#{Cryptoexchange::Exchanges::ThreeXbit::Market::API_URL}/v1/orderbook/#{target}/#{base}/"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new

          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = ThreeXbit::Market::NAME
          order_book.asks      = adapt_orders(output['sell_orders'])
          order_book.bids      = adapt_orders(output['buy_orders'])
          order_book.timestamp = nil
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order_entry|
            Cryptoexchange::Models::Order.new(
              price:  NumericHelper.to_d(order_entry['unit_price']),
              amount: NumericHelper.to_d(order_entry['quantity'])
            )
          end
        end
      end
    end
  end
end
