module Cryptoexchange::Exchanges
  module SaturnNetwork
    module Services
      class OrderBook < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(orderbook_url(market_pair))
          adapt(output, market_pair)
        end

        def orderbook_url(market_pair)
          "#{Cryptoexchange::Exchanges::SaturnNetwork::Market::API_URL}/api/v2/orders/#{market_pair.target}/#{market_pair.base}/#{ether_address}/all.json"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new

          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = SaturnNetwork::Market::NAME
          order_book.asks      = adapt_orders(output["buys"])
          order_book.bids      = adapt_orders(output["sells"])
          order_book.timestamp = nil
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order_entry|
            Cryptoexchange::Models::Order.new(price: order_entry["price"].to_f,
                                              amount: order_entry["balance"].to_f,
                                              timestamp: order_entry["created_at"])
          end
        end

        private

        def ether_address
          "0x0000000000000000000000000000000000000000"
        end
      end
    end
  end
end
