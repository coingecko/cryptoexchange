module Cryptoexchange::Exchanges
  module Boa
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
          "#{Cryptoexchange::Exchanges::Boa::Market::API_URL}/#{market_pair.base}_#{market_pair.target}/orderbook?side=both&limit=100"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new
          output               = output["data"]
          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Boa::Market::NAME
          order_book.asks      = adapt_orders(output['sell'])
          order_book.bids      = adapt_orders(output['buy'])
          order_book.timestamp = Time.now.to_i
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order_entry|
            Cryptoexchange::Models::Order.new(price:  order_entry[0],
                                              amount: order_entry[1],
                                              timestamp: nil,
            )
          end
        end
      end
    end
  end
end
