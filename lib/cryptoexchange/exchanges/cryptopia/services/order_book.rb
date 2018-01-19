module Cryptoexchange::Exchanges
  module Cryptopia
    module Services
      class OrderBook < Cryptoexchange::Services::Market
        MAXIMUM_DEPTH = 100000

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
          "#{Cryptoexchange::Exchanges::Cryptopia::Market::API_URL}/GetMarketOrders/#{market_pair.base}_#{market_pair.target}/#{MAXIMUM_DEPTH}"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new

          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Cryptopia::Market::NAME
          order_book.asks      = adapt_orders output['Data']['Sell']
          order_book.bids      = adapt_orders output['Data']['Buy']
          order_book.timestamp = Time.now.to_i
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order_entry|
            Cryptoexchange::Models::Order.new(
              price: order_entry['Price'],
              amount: order_entry['Volume'],
              timestamp: nil
            )
          end
        end
      end
    end
  end
end
