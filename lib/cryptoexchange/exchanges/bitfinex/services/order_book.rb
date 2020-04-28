module Cryptoexchange::Exchanges
  module Bitfinex
    module Services
      class OrderBook < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(order_book_url(market_pair))
          adapt(output, market_pair)
        end

        def order_book_url(market_pair)
          "#{Cryptoexchange::Exchanges::Bitfinex::Market::API_URL}/book/#{market_pair.inst_id}/P2?len=100"
        end

        def adapt(output, market_pair)
          bids = []
          asks = []
          output.each do |output|
            if output[2] > 0
              bids << output
            else
              output[2] = -(output[2])
              asks << output
            end
          end  
          order_book = Cryptoexchange::Models::OrderBook.new

          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Bitfinex::Market::NAME
          order_book.asks      = adapt_orders(asks)
          order_book.bids      = adapt_orders(bids)
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order_entry|
            Cryptoexchange::Models::Order.new(price: NumericHelper.to_d(order_entry[0]),
                                              amount: NumericHelper.to_d(order_entry[2]),
                                              timestamp: nil)
          end
        end
      end
    end
  end
end
