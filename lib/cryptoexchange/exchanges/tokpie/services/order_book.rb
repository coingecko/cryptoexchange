module Cryptoexchange::Exchanges
  module Tokpie
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
          "#{Cryptoexchange::Exchanges::Tokpie::Market::API_URL}/api_order_book/?market=#{market_pair.base.upcase}@#{market_pair.target.upcase}&size=10"
        end

        def adapt(output, market_pair)
          timestamp = DateTime.parse(output['result']['aob_datetime']).to_time.to_i
          order_book = Cryptoexchange::Models::OrderBook.new
          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Tokpie::Market::NAME
          order_book.asks      = adapt_orders(output['result']['aob_ask'], timestamp)
          order_book.bids      = adapt_orders(output['result']['aob_bid'], timestamp)
          order_book.timestamp = timestamp
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders, timestamp)
          orders.collect do |order_entry|
            Cryptoexchange::Models::Order.new(
              price:     order_entry[0],
              amount:    order_entry[1],
              timestamp: timestamp
            )
          end
        end
      end
    end
  end
end
