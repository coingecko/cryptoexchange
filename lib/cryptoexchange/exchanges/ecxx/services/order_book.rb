module Cryptoexchange::Exchanges
  module Ecxx
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
          base   = market_pair.base
          target = market_pair.target
          "https://www.ecxx.com/exapi/klineApi/getmarket/#{base}_#{target}"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new

          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Ecxx::Market::NAME
          order_book.asks      = adapt_orders(output['asks'])
          order_book.bids      = adapt_orders(output['bids'])
          order_book.timestamp = nil
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders)
          new_orders = orders["price"].map.each_with_index { |order, index| { "price": order, "amount": orders["amount"][index] } }
          new_orders.collect do |order_entry|
            Cryptoexchange::Models::Order.new(price:     order_entry[:price],
                                              amount:    order_entry[:amount],
                                              timestamp: nil)
          end
        end
      end
    end
  end
end
