module Cryptoexchange::Exchanges
  module Bgogo
    module Services
      class OrderBook < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = Bgogo::Market.ticker_fetch(order_book_url(market_pair))
          adapt(output, market_pair)
        end

        def order_book_url(market_pair)
          base = market_pair.base
          target = market_pair.target
          "#{Cryptoexchange::Exchanges::Bgogo::Market::API_URL}/snapshot/#{base}/#{target}"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new
          depth = output['order_book']

          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Bgogo::Market::NAME
          order_book.asks      = adapt_orders depth['asks']
          order_book.bids      = adapt_orders depth['bids']
          order_book.timestamp = nil
          order_book.payload   = depth
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order_entry|
            Cryptoexchange::Models::Order.new(price: order_entry['price'],
                                              amount: order_entry['amount'],
                                              timestamp: nil)
          end
        end
      end
    end
  end
end
