module Cryptoexchange::Exchanges
  module Lukki
    module Services
      class OrderBook < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          ctx = OpenSSL::SSL::SSLContext.new
          ctx.verify_mode = OpenSSL::SSL::VERIFY_NONE

          output = Cryptoexchange::Cache.ticker_cache.fetch(ticker_url(market_pair)) do
            HTTP.get(ticker_url(market_pair), ssl_context: ctx).parse(:json)
          end

          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Lukki::Market::API_URL}/trading/books?page=1&ticker=#{market_pair.base.downcase}_#{market_pair.target.downcase}"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new
          asks = output["data"].map { |n| n if n["direction"] == 1 }.compact
          bids = output["data"].map { |n| n if n["direction"] == 0 }.compact

          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Lukki::Market::NAME

          order_book.asks      = asks.nil? ? nil : adapt_orders(asks)
          order_book.bids      = bids.nil? ? nil : adapt_orders(bids)
          order_book.timestamp = nil
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order_entry|
            Cryptoexchange::Models::Order.new(price: order_entry["price"].to_f,
                                              amount: order_entry["amount"].to_f,
                                              timestamp: nil)
          end
        end
      end
    end
  end
end
