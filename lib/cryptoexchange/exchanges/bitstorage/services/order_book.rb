module Cryptoexchange::Exchanges
  module Bitstorage
    module Services
      class OrderBook < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Bitstorage::Market::API_URL}/order-book?market=#{market_pair.base}&currency=#{market_pair.target}"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new

          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Bitstorage::Market::NAME
          order_book.asks      = output['order-book']['ask'].empty? ? ['Nil'] : adapt_orders(output['order-book']['ask'])
          order_book.bids      = output['order-book']['bid'].empty? ? ['Nil'] : adapt_orders(output['order-book']['bid'])
          order_book.timestamp = nil
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order_entry|
            Cryptoexchange::Models::Order.new(price: order_entry['price'],
                                              amount: order_entry['order_amount'],
                                              timestamp: order_entry['timestamp'])
          end
        end
      end
    end
  end
end
