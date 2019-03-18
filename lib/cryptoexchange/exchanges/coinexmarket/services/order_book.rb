module Cryptoexchange::Exchanges
  module Coinexmarket
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
          "#{Cryptoexchange::Exchanges::Coinexmarket::Market::API_URL}/orderBook/#{market_pair.base}_#{market_pair.target}"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new

          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Coinexmarket::Market::NAME
          order_book.asks      = output['sellorder'].empty? ? ['nil'] : adapt_orders(output['sellorder'])
          order_book.bids      = output['buyorder'].empty? ? ['nil'] : adapt_orders(output['buyorder'])
          order_book.timestamp = Time.now.to_i
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order_entry|
            Cryptoexchange::Models::Order.new(price: order_entry['orders_coincost'],
                                              amount: order_entry['orders_coins'],
                                              timestamp: nil)
          end
        end
      end
    end
  end
end
