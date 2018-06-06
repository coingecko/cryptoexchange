module Cryptoexchange::Exchanges
  module Bitpaction
    module Services
      class OrderBook < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          bid_output = super(bid_url(market_pair))
          ask_output = super(ask_url(market_pair))
          bids       = grab_all_order_book_data(bid_output)
          asks       = grab_all_order_book_data(ask_output)
          adapt(bids, asks, market_pair)
        end

        def bid_url(market_pair)
          base   = market_pair.base
          target = market_pair.target
          "#{Cryptoexchange::Exchanges::Bitpaction::Market::API_URL}/market/buys-list?symbol=#{base}-#{target}"
        end

        def ask_url(market_pair)
          base   = market_pair.base
          target = market_pair.target
          "#{Cryptoexchange::Exchanges::Bitpaction::Market::API_URL}/market/sells-list?symbol=#{base}-#{target}"
        end

        def grab_all_order_book_data(output)
          list = []
          output['data'].map do |orders|
            orders.each do |key, value|
              next if key == 'decimal'
              list << value
            end
          end
          list.flatten
        end

        def adapt(bids, asks, market_pair)
          order_book           = Cryptoexchange::Models::OrderBook.new
          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Bitpaction::Market::NAME
          order_book.asks      = adapt_orders bids
          order_book.bids      = adapt_orders asks
          order_book.timestamp = Time.now.to_i
          order_book.payload   = { bids: bids, asks: asks }
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order_entry|
            price  = order_entry['price']
            amount = order_entry['number']
            Cryptoexchange::Models::Order.new(price:  price,
                                              amount: amount)
          end
        end
      end
    end
  end
end
