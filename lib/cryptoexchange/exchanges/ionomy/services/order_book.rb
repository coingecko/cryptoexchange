module Cryptoexchange::Exchanges
  module Ionomy
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
          base   = market_pair.base
          target = market_pair.target
          "#{Cryptoexchange::Exchanges::Ionomy::Market::API_URL}/public/orderbook?market=#{target}-#{base}&type=both"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new

          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Ionomy::Market::NAME
          order_book.asks      = adapt_orders output['data']['asks']
          order_book.bids      = adapt_orders output['data']['bids']
          order_book.timestamp = nil
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order_entry|
            Cryptoexchange::Models::Order.new(price:  order_entry['price'],
                                              amount: order_entry['size']
            )
          end
        end
      end
    end
  end
end
