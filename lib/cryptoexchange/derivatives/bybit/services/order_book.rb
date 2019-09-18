module Cryptoexchange::Exchanges
  module Bybit
    module Services
      class OrderBook < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          asks = output["result"].select { |d| d["side"] == "Sell" }
          bids = output["result"].select { |d| d["side"] == "Buy" }
          output = { asks: asks, bids: bids }
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Bybit::Market::API_URL}/orderBook/L2?symbol=#{market_pair.base.upcase}#{market_pair.target.upcase}"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new

          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Bybit::Market::NAME
          order_book.asks      = adapt_orders(output[:asks])
          order_book.bids      = adapt_orders(output[:bids])
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order_entry|
            Cryptoexchange::Models::Order.new(price: NumericHelper.to_d(order_entry["price"]),
                                              amount: NumericHelper.to_d(order_entry["size"]),
                                              timestamp: nil)
          end
        end
      end
    end
  end
end
