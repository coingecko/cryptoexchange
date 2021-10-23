module Cryptoexchange::Exchanges
  module Dcoin
    module Services
      class OrderBook < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(orderbook_url(market_pair))
          adapt(output, market_pair)
        end

        def orderbook_url(market_pair)
          "#{Cryptoexchange::Exchanges::Dcoin::Market::API_URL}/open/api/market_dept?symbol=#{market_pair.base.downcase}#{market_pair.target.downcase}&type=step0"
        end

        def adapt(output, market_pair)
          output = output['data']
          order_book = Cryptoexchange::Models::OrderBook.new

          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Dcoin::Market::NAME
          order_book.asks      = adapt_orders(output['asks'])
          order_book.bids      = adapt_orders(output['bids'])
          order_book.timestamp = nil
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order_entry|
            Cryptoexchange::Models::Order.new(price: order_entry[0],
                                              amount: order_entry[1],
                                              timestamp: nil)
          end
        end
      end
    end
  end
end
