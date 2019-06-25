module Cryptoexchange::Exchanges
  module Bitinka
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
          # currency is the determined by the coin / currency BTC is traded in
          "#{Cryptoexchange::Exchanges::Bitinka::Market::API_URL}/order_book/#{market_pair.base}_#{market_pair.target}?format=json"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new

          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Bitinka::Market::NAME
          order_book.asks      = adapt_orders(output['orders']['purchases'])
          order_book.bids      = adapt_orders(output['orders']['sales'])
          order_book.timestamp = nil
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders)
          return if orders.nil? || orders.values.nil?

          orders = orders.values.flatten
          orders.map do |order_entry|
            Cryptoexchange::Models::Order.new(
              price: order_entry['Price'],
              amount: order_entry['Amount']
            )
          end
        end
      end
    end
  end
end
