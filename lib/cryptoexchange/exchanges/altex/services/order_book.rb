module Cryptoexchange::Exchanges
  module Altex
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
          "#{Cryptoexchange::Exchanges::Altex::Market::API_URL}/orderBook/market/#{market_pair.base.upcase}_#{market_pair.target.upcase}"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new
          timestamp = Time.now.to_i

          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Altex::Market::NAME

          order_book.bids      = adapt_orders(output["data"].select{ |s| s['type'] == 'buy' })
          order_book.asks      = adapt_orders(output["data"].select{ |s| s['type'] == 'sell' })

          order_book.timestamp = timestamp
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order_entry|
            Cryptoexchange::Models::Order.new(price: order_entry["price"],
                                              amount: order_entry["amount"],
                                              timestamp: order_entry["timestamp"])
          end
        end
      end
    end
  end
end
