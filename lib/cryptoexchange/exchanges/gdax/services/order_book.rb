module Cryptoexchange::Exchanges
  module Gdax
    module Services
      class OrderBook < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        # The level to retrieve order book is default at 2 
        def fetch(market_pair, level = 2)
          output = super(ticker_url(market_pair, level))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair, level)
          base = market_pair.base.downcase
          target = market_pair.target.downcase
          "#{Cryptoexchange::Exchanges::Gdax::Market::API_URL}/products/#{base}-#{target}/book?level=#{level}"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new
          timestamp = output['timestamp'].to_i

          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Gdax::Market::NAME
          order_book.asks      = adapt_orders(output['asks'], timestamp)
          order_book.bids      = adapt_orders(output['bids'], timestamp)
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders, timestamp)
          orders.collect do |order_entry|
            price = order_entry[0]
            amount = order_entry[1]

            Cryptoexchange::Models::Order.new(
              price: price,
              amount: amount,
              timestamp: Time.now
            )
          end
        end
      end
    end
  end
end
