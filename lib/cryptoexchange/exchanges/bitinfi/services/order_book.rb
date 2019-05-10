module Cryptoexchange::Exchanges
  module Bitinfi
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
          "#{Cryptoexchange::Exchanges::Bitinfi::Market::API_URL}/depth.ashx?symbol=#{market_pair.base}_#{market_pair.target}&limit=100&lang=eng&version=9.9.9"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new

          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Bitinfi::Market::NAME
          order_book.asks      = adapt_orders(output['data']['asks'])
          order_book.bids      = adapt_orders(output['data']['bids'])
          order_book.timestamp = nil
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders)
          orders.map do |order_entry|
            Cryptoexchange::Models::Order.new(
              price: order_entry['price'],
              amount: order_entry['quantity']
            )
          end
        end
      end
    end
  end
end
