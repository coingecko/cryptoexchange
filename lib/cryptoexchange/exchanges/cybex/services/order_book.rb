module Cryptoexchange::Exchanges
  module Cybex
    module Services
      class OrderBook < Cryptoexchange::Services::Market
        MAXIMUM_DEPTH = 50

        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          base, target = Cybex::Market.prepend_symbol_prefix(market_pair)
          output = fetch_using_post(ticker_url, { "jsonrpc": "2.0", "method": "get_order_book", "params": ["#{target}", "#{base}", "#{MAXIMUM_DEPTH}"], "id": 1 })
          # puts output
          adapt(output, market_pair)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Cybex::Market::API_URL}"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new

          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Cybex::Market::NAME
          order_book.asks      = adapt_orders output['result']['asks']
          order_book.bids      = adapt_orders output['result']['bids']
          order_book.timestamp = Time.now.to_i
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order_entry|
            Cryptoexchange::Models::Order.new(
              price: order_entry['price'],
              amount: order_entry['quote'],
              timestamp: nil
            )
          end
        end
      end
    end
  end
end
