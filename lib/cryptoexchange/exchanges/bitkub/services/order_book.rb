module Cryptoexchange::Exchanges
  module Bitkub
    module Services
      class OrderBook < Cryptoexchange::Services::Market
        ORDER_LIMIT = 50
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
          base   = market_pair.base
          target = market_pair.target
          "#{Cryptoexchange::Exchanges::Bitkub::Market::API_URL}/market/asks?sym=#{target}_#{base}&lmt=#{ORDER_LIMIT}"
        end

        def bids_url(market_pair)
          base   = market_pair.base
          target = market_pair.target
          "#{Cryptoexchange::Exchanges::Bitkub::Market::API_URL}/market/bids?sym=#{target}_#{base}&lmt=#{ORDER_LIMIT}"
        end

        def adapt(asks, bids, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new

          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Bitkub::Market::NAME
          order_book.asks      = adapt_orders(asks['result'])
          order_book.bids      = adapt_orders(bids['result'])
          order_book.timestamp = nil
          order_book.payload   = [asks, bids]
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order_entry|
            Cryptoexchange::Models::Order.new(
              price:     order_entry[3],
              amount:    order_entry[-1],
              timestamp: order_entry[1]
            )
          end
        end
      end
    end
  end
end
