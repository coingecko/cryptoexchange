module Cryptoexchange::Exchanges
  module Buyucoin
    module Services
      class OrderBook < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output['data'], market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Buyucoin::Market::API_URL}/liveOrderBook?symbol=#{market_pair.target}-#{market_pair.base}"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new

          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Buyucoin::Market::NAME
          order_book.asks      = adapt_orders(output['SELL'])
          order_book.bids      = adapt_orders(output['BUY'])
          order_book.timestamp = nil
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order|
            Cryptoexchange::Models::Order.new(price: order["price"].to_f,
                                              amount: order["qty"].to_f,
                                              timestamp: nil)
          end
        end
      end
    end
  end
end
