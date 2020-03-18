module Cryptoexchange::Exchanges
  module Phemex
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
          "#{Cryptoexchange::Exchanges::Phemex::Market::API_URL}/orderbook?symbol=#{market_pair.inst_id}"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new
          order_book.base = market_pair.base
          order_book.target = market_pair.target
          order_book.market = Phemex::Market::NAME

          order_book.asks = adapt_orders(output["result"]["book"]['asks'])
          order_book.bids = adapt_orders(output["result"]["book"]['bids'])
          order_book.timestamp = nil
          order_book.payload = output
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order_entry|
            Cryptoexchange::Models::Order.new(price: NumericHelper.divide(NumericHelper.to_d(order_entry[0]), 10000),
                                              amount: order_entry[1],
                                              timestamp: nil)
          end
        end
      end
    end
  end
end
