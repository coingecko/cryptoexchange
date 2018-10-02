module Cryptoexchange::Exchanges
  module Dragonex
    module Services
      class OrderBook < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          asks_output = super(asks_url(market_pair))
          bids_output = super(bids_url(market_pair))
          adapt(asks_output, bids_output, market_pair)
        end

        def asks_url(market_pair)
          id = market_pair.id
          "#{Cryptoexchange::Exchanges::Dragonex::Market::API_URL}/api/v1/market/sell/?symbol_id=#{id}"
        end

        def bids_url(market_pair)
          id = market_pair.id
          "#{Cryptoexchange::Exchanges::Dragonex::Market::API_URL}/api/v1/market/buy/?symbol_id=#{id}"
        end

        def adapt(asks, bids, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new

          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Dragonex::Market::NAME
          order_book.asks      = adapt_orders(asks['data'])
          order_book.bids      = adapt_orders(bids['data'])
          order_book.payload   = [asks, bids]
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order_entry|
            price  = order_entry['price']
            amount = order_entry['volume']
            Cryptoexchange::Models::Order.new(price:  price,
                                              amount: amount)
          end
        end
      end
    end
  end
end
