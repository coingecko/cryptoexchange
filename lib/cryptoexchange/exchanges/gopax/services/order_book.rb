module Cryptoexchange::Exchanges
  module Gopax
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
          "#{Cryptoexchange::Exchanges::Gopax::Market::API_URL}trading-pairs/#{market_pair.base}-#{market_pair.target}/book"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new
          order_book.base = market_pair.base
          order_book.target = market_pair.target
          order_book.market = Gopax::Market::NAME
          order_book.asks = adapt_orders(output['ask'])
          order_book.bids = adapt_orders(output['bid'])
          order_book.timestamp = Time.now.to_i
          order_book.payload = output
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order_entry|
            price, amount = order_entry
            Cryptoexchange::Models::Order.new(price: order_entry[1],
                                              amount: order_entry[2],
                                              timestamp: Time.now.to_i)
          end
        end
      end
    end
  end
end
