module Cryptoexchange::Exchanges
  module Binance
    module Services
      class OrderBook < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(order_book_url(market_pair))
          adapt(output, market_pair)
        end

        def order_book_url(market_pair)
          base = market_pair.base
          target = market_pair.target
          "#{Cryptoexchange::Exchanges::Binance::Market::API_URL}/depth?symbol=#{base}#{target}"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new
          timestamp = Time.now.to_i

          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Binance::Market::NAME
          order_book.asks      = adapt_orders(output['asks'], timestamp)
          order_book.bids      = adapt_orders(output['bids'], timestamp)
          order_book.timestamp = timestamp
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders, timestamp)
          # Format as: [price, amount, timestamp]
          orders.collect { |order_entry| order_entry.flatten.push timestamp.to_s }
        end
      end
    end
  end
end
