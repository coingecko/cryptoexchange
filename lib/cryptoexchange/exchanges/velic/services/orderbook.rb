module Cryptoexchange::Exchanges
  module Velic
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
          "#{Cryptoexchange::Exchanges::Velic::Market::API_URL}/public/orderbook?base_coin=#{market_pair.target}&match_coin=#{market_pair.base}"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new

          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Velic::Market::NAME
          order_book.asks      = adapt_orders(output['sell_list'])
          order_book.bids      = adapt_orders(output['buy_list'])
          order_book.timestamp = nil
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order_entry|
            Cryptoexchange::Models::Order.new(
              price: NumericHelper.to_d(order_entry["price"]),
              amount: NumericHelper.to_d(order_entry["amount"])
            )
          end
        end
      end
    end
  end
end
