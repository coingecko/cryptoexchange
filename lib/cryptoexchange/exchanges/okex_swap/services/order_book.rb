module Cryptoexchange::Exchanges
  module OkexSwap
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
          symbol = "#{market_pair.base}-#{market_pair.target}-SWAP"
          "#{Cryptoexchange::Exchanges::OkexSwap::Market::API_URL}/instruments/#{symbol}/depth?size=200"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new
          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = OkexSwap::Market::NAME
          order_book.asks      = adapt_orders(output["asks"])
          order_book.bids      = adapt_orders(output["bids"])
          order_book.timestamp = nil
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order_entry|
            Cryptoexchange::Models::Order.new(price: order_entry[0].to_f,
                                              amount: order_entry[1].to_f,
                                              timestamp: nil)
          end
        end
      end
    end
  end
end
