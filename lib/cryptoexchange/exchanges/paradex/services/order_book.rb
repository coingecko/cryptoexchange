module Cryptoexchange::Exchanges
  module Paradex
    module Services
      class OrderBook < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          authentication = Cryptoexchange::Exchanges::Paradex::Authentication.new(
            :market,
            Paradex::Market::NAME
          )
          authentication.validate_credentials!

          headers = authentication.headers(nil)
          output  = Cryptoexchange::Exchanges::Paradex::Market.fetch_via_api(ticker_url(market_pair), headers)
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          base   = market_pair.base
          target = market_pair.target
          "#{Cryptoexchange::Exchanges::Paradex::Market::API_URL}/v0/orderbook?market=#{base}/#{target}"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new

          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Paradex::Market::NAME
          order_book.asks      = adapt_orders(output['asks'])
          order_book.bids      = adapt_orders(output['bids'])
          order_book.timestamp = Time.now.to_i
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order_entry|
            price  = order_entry['price']
            amount = order_entry['amount']
            Cryptoexchange::Models::Order.new(price:     price,
                                              amount:    amount,
                                              timestamp: nil)
          end
        end
      end
    end
  end
end
