module Cryptoexchange::Exchanges
  module Paribu
    module Services
      class OrderBook < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end
        require 'byebug'
        def fetch
          byebug
          raw_output = HTTP.get(ticker_url)
          output = JSON.parse(raw_output.to_s)
          adapt(output)
        end

        def ticker_url
          "https://www.paribu.com/endpoint/state"
        end

        def adapt(output)
          order_book = Cryptoexchange::Models::OrderBook.new
          timestamp = Time.now.to_i
          byebug
          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Paribu::Market::NAME
          order_book.asks      = adapt_orders(output['asks'])
          order_book.bids      = adapt_orders(output['bids'])
          order_book.timestamp = timestamp
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order_entry|
            price, amount = order_entry
            Cryptoexchange::Models::Order.new(price: price,
                                              amount: amount,
                                              timestamp: nil)
          end
        end
      end
    end
  end
end
