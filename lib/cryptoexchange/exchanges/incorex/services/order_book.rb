module Cryptoexchange::Exchanges
  module Incorex
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
          "#{Cryptoexchange::Exchanges::Incorex::Market::API_URL}/order_book/?pair=#{market_pair.base}_#{market_pair.target}"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new

          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Incorex::Market::NAME
          order_book.asks      = adapt_orders output.values.first['ask']
          order_book.bids      = adapt_orders output.values.first['bid']
          order_book.timestamp = Time.now.to_i
          order_book.payload   = output.values.first
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order_entry|
            price, quantity, amount = order_entry
            Cryptoexchange::Models::Order.new(price: price,
                                              amount: quantity,
                                              timestamp: nil)
          end
        end
      end
    end
  end
end
