module Cryptoexchange::Exchanges
  module StakeCube
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
          "#{Cryptoexchange::Exchanges::StakeCube::Market::API_URL}/exchange/orders?base=#{market_pair.target}&target=#{market_pair.base}&limit=50"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new

          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = StakeCube::Market::NAME
          order_book.asks      = adapt_orders output['asks']
          order_book.bids      = adapt_orders output['bids']
          order_book.timestamp = nil
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
