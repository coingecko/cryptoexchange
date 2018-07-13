module Cryptoexchange::Exchanges
  module C2cx
    module Services
      class OrderBook < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          response = super(order_book_url(market_pair))
          adapt(response, market_pair)
        end

        def order_book_url(market_pair)
          base   = market_pair.base.upcase
          target = market_pair.target.upcase
          "#{Cryptoexchange::Exchanges::C2cx::Market::API_URL}/getorderbook?symbol=#{base}_#{target}"
        end

        def adapt(response, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new
          timestamp  = Time.now.to_i
          data       = response['data']

          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = C2cx::Market::NAME
          order_book.asks      = adapt_orders(data['asks'])
          order_book.bids      = adapt_orders(data['bids'])
          order_book.timestamp = timestamp
          order_book.payload   = response
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order|
            price, amount = order
            Cryptoexchange::Models::Order.new(price:     price,
                                              amount:    amount,
                                              timestamp: nil)
          end
        end
      end
    end
  end
end