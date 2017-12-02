module Cryptoexchange::Exchanges
  module Okex
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
          "#{Cryptoexchange::Exchanges::Okex::Market::API_URL}/depth.do?symbol=#{market_pair.base.downcase}_#{market_pair.target.downcase}"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new
          timestamp = Time.now.to_i

          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Okex::Market::NAME
          order_book.asks      = adapt_orders(output['asks'], timestamp)
          order_book.bids      = adapt_orders(output['bids'], timestamp)
          order_book.timestamp = Time.now.to_i
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders, timestamp)
          orders.collect do |order_entry|
            price = order_entry[0]
            amount = order_entry[1]
            Cryptoexchange::Models::Order.new(price: price,
                                              amount: amount,
                                              timestamp: timestamp)
          end
        end
      end
    end
  end
end
