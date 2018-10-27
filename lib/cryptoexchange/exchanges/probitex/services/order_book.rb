module Cryptoexchange::Exchanges
  module Probitex
    module Services
      class OrderBook < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(order_book_url(market_pair))
          adapt(output['data'], market_pair)
        end

        def order_book_url(market_pair)
          base   = market_pair.base.downcase
          target = market_pair.target.downcase
          "#{Cryptoexchange::Exchanges::Probitex::Market::API_URL}/get_market_depth?name=#{base}_#{target}"
        end

        def adapt(output, market_pair)
          order_book           = Cryptoexchange::Models::OrderBook.new
          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Probitex::Market::NAME
          order_book.asks      = adapt_orders(output['sell'])
          order_book.bids      = adapt_orders(output['buy'])
          order_book.timestamp = nil
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order_entry|
            Cryptoexchange::Models::Order.new(price:     order_entry['p'],
                                              amount:    order_entry['n'],
                                              timestamp: nil)
          end
        end
      end
    end
  end
end
