module Cryptoexchange::Exchanges
  module Coinhub
    module Services
      class OrderBook < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          raw_output = HTTP.accept(:json).post(ticker_url, json:{ "market": "#{market_pair.base}-#{market_pair.target}", "count": 20})
          output = JSON.parse(raw_output)
          adapt(output['results'], market_pair)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Coinhub::Market::API_URL}/public/bestOffer"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new

          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Coinhub::Market::NAME
          order_book.asks      = adapt_orders(output['ask'])
          order_book.bids      = adapt_orders(output['bid'])
          order_book.timestamp = nil
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order_entry|
            Cryptoexchange::Models::Order.new(price: order_entry[0],
                                              amount: order_entry[1])
          end
        end
      end
    end
  end
end
