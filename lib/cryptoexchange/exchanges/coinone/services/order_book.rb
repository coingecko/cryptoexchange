module Cryptoexchange::Exchanges
  module Coinone
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
          base = market_pair.base.downcase

          "#{Cryptoexchange::Exchanges::Coinone::Market::API_URL}/orderbook/?currency=#{base}"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new
          timestamp = output['timestamp'].to_i

          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Coinone::Market::NAME
          order_book.asks      = adapt_orders(output['ask'], timestamp)
          order_book.bids      = adapt_orders(output['bid'], timestamp)
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders, timestamp)
          orders.collect do |order_entry|
            price = order_entry['price']
            amount = order_entry['qty']

            Cryptoexchange::Models::Order.new(
              price: price,
              amount: amount,
              timestamp: timestamp
            )
          end
        end
      end
    end
  end
end
