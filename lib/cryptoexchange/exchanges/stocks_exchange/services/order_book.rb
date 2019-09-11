module Cryptoexchange::Exchanges
  module StocksExchange
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
          "#{Cryptoexchange::Exchanges::StocksExchange::Market::API_URL}/orderbook/#{market_pair.inst_id}?limit_bids=100&limit_asks=100"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new
          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = StocksExchange::Market::NAME
          order_book.asks      = adapt_orders(output["data"]["ask"])
          order_book.bids      = adapt_orders(output["data"]["bid"])
          order_book.timestamp = nil
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order_entry|
            Cryptoexchange::Models::Order.new(
              price: order_entry["price"].to_f,
              amount: order_entry["amount"].to_f
            )
          end
        end
      end
    end
  end
end
