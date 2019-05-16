module Cryptoexchange::Exchanges
  module Zb
    module Services
      class OrderBook < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(orderbook_url(market_pair))
          adapt(output, market_pair)
        end

        def orderbook_url(market_pair)
          "#{Cryptoexchange::Exchanges::Zb::Market::API_URL}/depth?market=#{market_pair.base.downcase}_#{market_pair.target.downcase}&size=50"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new
          timestamp = output["timestamp"].to_i

          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Zb::Market::NAME
          order_book.asks      = adapt_orders(output["asks"])
          order_book.bids      = adapt_orders(output["bids"])
          order_book.timestamp = timestamp
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order_entry|
            Cryptoexchange::Models::Order.new(price: order_entry[0],
                                              amount: order_entry[1],
                                              timestamp: nil)
          end
        end
      end
    end
  end
end
