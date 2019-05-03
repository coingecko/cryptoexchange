  module Cryptoexchange::Exchanges
  module Poloniex
    module Services
      class OrderBook < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          output = super(self.order_book_url)
          adapt_all(output)
        end

        def order_book_url
          "#{Cryptoexchange::Exchanges::Poloniex::Market::API_URL}?command=returnOrderBook&currencyPair=all&depth=100"
        end

        def adapt_all(output)
          output.map do |pair, ticker|
            # Target comes first in Poloniex ie. BTC-BCN
            # BTC cannot be a base in this pair
            target, base = pair.split('_')
            market_pair = Cryptoexchange::Models::MarketPair.new(
                            base: base,
                            target: target,
                            market: Poloniex::Market::NAME
                          )

            adapt(ticker, market_pair)
          end
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new

          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Poloniex::Market::NAME
          order_book.asks      = adapt_orders(output['asks'])
          order_book.bids      = adapt_orders(output['bids'])
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order_entry|
            Cryptoexchange::Models::Order.new(price: NumericHelper.to_d(order_entry[0]),
                                              amount: NumericHelper.to_d(order_entry[1]),
                                              timestamp: nil)
          end
        end
      end
    end
  end
end
