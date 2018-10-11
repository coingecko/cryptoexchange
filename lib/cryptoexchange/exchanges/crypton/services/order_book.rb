module Cryptoexchange::Exchanges
  module Crypton
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
          "#{Cryptoexchange::Exchanges::Crypton::Market::API_URL}/markets/#{market_pair.base}-#{market_pair.target}/orderbook?depth=50"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new

          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Crypton::Market::NAME
          order_book.asks      = adapt_orders(output['result']['asks'])
          order_book.bids      = adapt_orders(output['result']['bids'])
          order_book.timestamp = Time.now.to_i
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order_entry|
            Cryptoexchange::Models::Order.new(price: NumericHelper.to_d(order_entry[0]),
                                              amount: NumericHelper.to_d(order_entry[1]),
                                              timestamp: nil)
          end
        end
      end
    end
  end
end
