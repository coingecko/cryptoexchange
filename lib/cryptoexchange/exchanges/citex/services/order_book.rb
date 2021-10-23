module Cryptoexchange::Exchanges
  module Citex
    module Services
      class OrderBook < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          authentication = Cryptoexchange::Exchanges::Citex::Authentication.new(
            :pairs,
            Cryptoexchange::Exchanges::Citex::Market::NAME
          )
          headers = authentication.headers
          output = Cryptoexchange::Cache.ticker_cache.fetch(ticker_url(market_pair)) do
            HTTP.timeout(15).headers(headers).get(ticker_url(market_pair)).parse :json
          end
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Citex::Market::API_URL}/snapshot/#{market_pair.base}-#{market_pair.target}"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new
          output     = output["data"]

          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Citex::Market::NAME

          order_book.asks      = adapt_orders output['asks']
          order_book.bids      = adapt_orders output['bids']
          order_book.timestamp = nil
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order_entry|
            Cryptoexchange::Models::Order.new(price: order_entry["price"].to_f,
                                              amount: order_entry["quantity"].to_f,
                                              timestamp: nil)
          end
        end
      end
    end
  end
end
