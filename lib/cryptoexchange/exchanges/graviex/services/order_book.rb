module Cryptoexchange::Exchanges
  module Graviex
    module Services
      class OrderBook < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(order_book(market_pair))
          adapt(output, market_pair)
        end

        def order_book(market_pair)
          market = "#{market_pair.base}#{market_pair.target}".downcase!
          "#{Cryptoexchange::Exchanges::Graviex::Market::API_URL}/order_book.json?market=#{market}"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new
          order_book.base = market_pair.base
          order_book.target = market_pair.target
          order_book.market = Graviex::Market::NAME
          order_book.asks = adapt_orders(output['asks'])
          order_book.bids = adapt_orders(output['bids'])
          order_book.timestamp = Time.now.to_i
          order_book.payload = output
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order_entry|
            Cryptoexchange::Models::Order.new(price: order_entry["price"],
                                              amount: order_entry["volume"],
                                              timestamp: nil)
          end
        end
      end
    end
  end
end
