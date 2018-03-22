module Cryptoexchange::Exchanges
  module Idex
    module Services
      class OrderBook < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          params = {}
          params['market'] = "#{market_pair.base}_#{market_pair.target}"
          output = fetch_using_post(ticker_url, params)
          adapt(output, market_pair)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Idex::Market::API_URL}/returnOrderBook"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new
          timestamp = Time.now.to_i

          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Idex::Market::NAME
          order_book.asks      = adapt_orders output['asks']
          order_book.bids      = adapt_orders output['bids']
          order_book.timestamp = timestamp
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order_entry|
            price = order_entry['price']
            amount = order_entry['amount']
            Cryptoexchange::Models::Order.new(price: price,
                                              amount: amount,
                                              timestamp: nil)
          end
        end
      end
    end
  end
end
