module Cryptoexchange::Exchanges
  module Dydx
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
          base = get_base(market_pair.base)
          "#{Cryptoexchange::Exchanges::Dydx::Market::API_URL}/orderbook/#{base}-#{market_pair.target}"
        end

        def get_base(base)
          return "WETH" if base == "ETH"
          base
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new

          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Dydx::Market::NAME
          order_book.asks      = adapt_orders(output['asks'], order_book.target)
          order_book.bids      = adapt_orders(output['bids'], order_book.target)
          order_book.timestamp = nil
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders, target)
          orders.collect do |order_entry|
            price = order_entry["price"]
            if target == "USDC"
              price = price.to_f * 1_000_000_000_000
            end
            Cryptoexchange::Models::Order.new(price: price,
                                              amount: order_entry["amount"],
                                              timestamp: nil)
          end
        end
      end
    end
  end
end
