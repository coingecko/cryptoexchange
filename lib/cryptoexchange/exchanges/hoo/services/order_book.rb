module Cryptoexchange::Exchanges
  module Hoo
    module Services
      class OrderBook < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          # Workaround for Hoo
          # Handling error response 200 getting cached
          # if error, clear the cache and bail out
          if output['code'] == 1
            Cryptoexchange::Cache.ticker_cache.delete(ticker_url(market_pair))
            return
          end
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          base   = market_pair.base
          target = market_pair.target
          "#{Cryptoexchange::Exchanges::Hoo::Market::API_URL}/depth/market?symbol=#{base}-#{target}"
        end

        def adapt(output, market_pair)
          output = output['data']
          order_book = Cryptoexchange::Models::OrderBook.new

          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Hoo::Market::NAME
          order_book.asks      = adapt_orders output['asks']
          order_book.bids      = adapt_orders output['bids']
          order_book.timestamp = nil
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order_entry|
            Cryptoexchange::Models::Order.new(price:  order_entry['price'],
                                              amount: order_entry['quantity']
            )
          end
        end
      end
    end
  end
end
