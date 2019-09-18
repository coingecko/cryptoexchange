module Cryptoexchange::Derivatives
  module Bitmex
    module Services
      class OrderBook < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(orderbook_url(market_pair))
          split_orderbook = split(output)
          adapt(split_orderbook, market_pair)
        end

        def orderbook_url(market_pair)
          "#{Cryptoexchange::Exchanges::Bitmex::Market::API_URL}/orderBook/L2?symbol=#{market_pair.inst_id}&depth=0"
        end

        def split(output)
          asks = []
          bids = []
            output.each do |order|
              order['side'].include?("Buy") ? bids<<order : asks<<order
            end
          {asks: asks, bids: bids}
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new
          timestamp = Time.now.to_i

          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Bitmex::Market::NAME
          order_book.asks      = adapt_orders(output[:asks])
          order_book.bids      = adapt_orders(output[:bids])
          order_book.timestamp = timestamp
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order_entry|
            Cryptoexchange::Models::Order.new(price: order_entry['price'],
                                              amount: order_entry['size'],
                                              timestamp: nil)
          end
        end
      end
    end
  end
end
