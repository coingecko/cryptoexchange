require 'pry'

module Cryptoexchange::Exchanges
  module Coinmate
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
          "#{Cryptoexchange::Exchanges::Coinmate::Market::API_URL}/orderBook?currencyPair=#{market_pair.base}_#{market_pair.target}&groupByPriceLimit=False"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new
          timestamp = Time.now.to_i

          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Coinmate::Market::NAME
          order_book.asks      = adapt_orders(output['data']['asks'], timestamp)
          order_book.bids      = adapt_orders(output['data']['bids'], timestamp)
          order_book.timestamp = timestamp
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders, timestamp)
          # Format as: [price, amount, timestamp]
          orders.collect { |order_entry| order_entry.values << timestamp }
        end
      end
    end
  end
end
