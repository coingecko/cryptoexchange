module Cryptoexchange::Exchanges
  module Fourteenbit
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
          "#{Cryptoexchange::Exchanges::Fourteenbit::Market::API_URL}/book/#{market_pair.target}/#{market_pair.base}"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new
          timestamp = Time.now.to_i

          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Fourteenbit::Market::NAME
          order_book.asks      = adapt_orders output['sellorders']
          order_book.bids      = adapt_orders output['buyorders']
          order_book.timestamp = timestamp
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order|
            Cryptoexchange::Models::Order.new(
              price:     order['price'],
              amount:    order['amount'],
              timestamp: nil
            )
          end
        end
      end
    end
  end
end
