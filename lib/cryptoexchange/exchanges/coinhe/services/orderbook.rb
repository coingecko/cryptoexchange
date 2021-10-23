module Cryptoexchange::Exchanges
  module Coinhe
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
          "#{Cryptoexchange::Exchanges::Coinhe::Market::API_URL}/order-book/?market=#{market_pair.base}_#{market_pair.target}"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new

          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Coinhe::Market::NAME
          order_book.asks      = adapt_orders(output['result']['asks'])
          order_book.bids      = adapt_orders(output['result']['bids'])
          order_book.timestamp = nil
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order_entry|
            Cryptoexchange::Models::Order.new(
              price: NumericHelper.to_d(order_entry[0]),
              amount: NumericHelper.to_d(order_entry[1])
            )
          end
        end
      end
    end
  end
end
