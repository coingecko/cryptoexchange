module Cryptoexchange::Exchanges
  module Bitholic
    module Services
      class OrderBook < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          output = super(order_book_url)
          adapt_all(output)
        end

        def order_book_url
          "#{Cryptoexchange::Exchanges::Bitholic::Market::API_URL}/orderbook"
        end

        def adapt_all(output)
          output.map do |pair, orders|
            target, base = pair.split('_')

            market_pair  = Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Bitholic::Market::NAME
            )
            adapt(market_pair, orders)
          end
        end

        def adapt(market_pair, orders)
          order_book = Cryptoexchange::Models::OrderBook.new

          order_book.base    = market_pair.base
          order_book.target  = market_pair.target
          order_book.market  = Bitholic::Market::NAME
          order_book.asks    = adapt_orders(orders['sell'])
          order_book.bids    = adapt_orders(orders['buy'])
          order_book.payload = orders
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order_entry|
            price, amount, _total = order_entry
            Cryptoexchange::Models::Order.new(
              price:     price,
              amount:    amount,
              timestamp: nil
            )
          end
        end
      end
    end
  end
end
