module Cryptoexchange::Exchanges
  module Btcexa
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
          base = market_pair.base
          target = market_pair.target
          "#{Cryptoexchange::Exchanges::Btcexa::Market::API_URL}/market/depth?limit=100&trading_pair=#{base.downcase}_#{target.downcase}"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new

          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Btcexa::Market::NAME
          order_book.asks      = adapt_orders(output['result']['ask'])
          order_book.bids      = adapt_orders(output['result']['bid'])
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order_entry|
            Cryptoexchange::Models::Order.new(price: NumericHelper.to_d(order_entry[1]),
                                              amount: NumericHelper.to_d(order_entry[2]),
                                              timestamp: nil)
          end
        end
      end
    end
  end
end
