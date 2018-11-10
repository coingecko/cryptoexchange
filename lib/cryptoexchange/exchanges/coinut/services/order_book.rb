module Cryptoexchange::Exchanges
  module Coinut
    module Services
      class OrderBook < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          authentication = Cryptoexchange::Exchanges::Coinut::Authentication.new(
            :order_book,
            Cryptoexchange::Exchanges::Coinut::Market::NAME
          )
          authentication.validate_credentials!

          payload_ = payload(market_pair)
          headers = authentication.headers(payload_)
          output = fetch_using_post(order_book_url, payload_, headers)
          adapt(output, market_pair)
        end

        def payload(market_pair)
          '{"nonce":' + SecureRandom.random_number(99999).to_s + ',"request":"inst_order_book", "inst_id":' + market_pair.inst_id + ', "top_n": 200, "decimal_places": 2 }'
        end

        def order_book_url
          Cryptoexchange::Exchanges::Coinut::Market::API_URL
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new
          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Coinut::Market::NAME
          order_book.asks      = adapt_orders(output["sell"])
          order_book.bids      = adapt_orders(output["buy"])
          order_book.timestamp = Time.now.to_i
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order_entry|
            Cryptoexchange::Models::Order.new(
              price: order_entry["price"],
              amount: order_entry["qty"],
              timestamp: nil
            )
          end
        end
      end
    end
  end
end
