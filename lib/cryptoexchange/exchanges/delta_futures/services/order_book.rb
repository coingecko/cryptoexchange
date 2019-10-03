module Cryptoexchange::Exchanges
  module DeltaFutures
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
          product_id = get_product_id(market_pair)
          "#{Cryptoexchange::Exchanges::DeltaFutures::Market::API_URL}/orderbook/#{product_id}/l2"
        end

        def get_product_id(market_pair)
          url = "#{Cryptoexchange::Exchanges::DeltaFutures::Market::API_URL}/products"
          output = HTTP.get(url).parse(:json)
          pair = output.find { |i| i['symbol'] == market_pair.inst_id }
          pair['id']
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new

          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = DeltaFutures::Market::NAME
          order_book.asks      = adapt_orders(output['sell_book'])
          order_book.bids      = adapt_orders(output['buy_book'])
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order_entry|
            Cryptoexchange::Models::Order.new(price: NumericHelper.to_d(order_entry["price"]),
                                              amount: NumericHelper.to_d(order_entry["size"]),
                                              timestamp: nil)
          end
        end
      end
    end
  end
end
