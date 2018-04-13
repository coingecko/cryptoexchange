module Cryptoexchange::Exchanges
  module Rightbtc
    module Services
      class OrderBook < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(order_book_url(market_pair))
          adapt(output['result'], market_pair)
        end

        def order_book_url(market_pair)
          "#{Cryptoexchange::Exchanges::Rightbtc::Market::API_URL}/depth/#{market_pair.base}#{market_pair.target}"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new
          timestamp = Time.now.to_i
          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Rightbtc::Market::NAME
          order_book.asks      = adapt_orders(output['ask'])
          order_book.bids      = adapt_orders(output['bid'])
          order_book.timestamp = timestamp
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order_entry|
            Cryptoexchange::Models::Order.new(price: NumericHelper.to_d(order_entry[0]),
                                              amount: NumericHelper.to_d(order_entry[2]),
                                              timestamp: nil)
          end

        end
      end
    end
  end
end
