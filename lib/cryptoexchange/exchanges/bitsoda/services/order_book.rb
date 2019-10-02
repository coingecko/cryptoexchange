module Cryptoexchange::Exchanges
  module Bitsoda
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
          "#{Cryptoexchange::Exchanges::Bitsoda::Market::API_URL}/market/snapshot/#{market_pair.base}_#{market_pair.target}"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new

          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Bitsoda::Market::NAME
          order_book.asks      = adapt_orders(output['data']['sellOrders'])
          order_book.bids      = adapt_orders(output['data']['buyOrders'])
          order_book.timestamp = nil
          order_book.payload   = output['data']
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order_entry|
            Cryptoexchange::Models::Order.new(
              price: NumericHelper.to_d(order_entry["price"]),
              amount: NumericHelper.to_d(order_entry["amount"])
            )
          end
        end
      end
    end
  end
end
