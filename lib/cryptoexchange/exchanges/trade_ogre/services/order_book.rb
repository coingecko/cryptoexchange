module Cryptoexchange::Exchanges
  module TradeOgre
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
          "#{Cryptoexchange::Exchanges::TradeOgre::Market::API_URL}/orders/#{market_pair.target}-#{market_pair.base}"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new
          timestamp = Time.now.to_i

          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = TradeOgre::Market::NAME
          order_book.asks      = adapt_orders output['sell']
          order_book.bids      = adapt_orders output['buy']
          order_book.timestamp = timestamp
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |key, value|
            Cryptoexchange::Models::Order.new(
              price:     key,
              amount:    value,
              timestamp: nil
            )
          end
        end
      end
    end
  end
end
