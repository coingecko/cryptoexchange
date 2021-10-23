module Cryptoexchange::Exchanges
  module Nominex
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
          base   = market_pair.base
          target = market_pair.target
          "#{Cryptoexchange::Exchanges::Nominex::Market::API_URL}/orderbook/#{base}/#{target}/A0/100"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new

          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Nominex::Market::NAME
          order_book.asks      = adapt_orders(output, "SELL")
          order_book.bids      = adapt_orders(output, "BUY")
          order_book.timestamp = nil
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders, type)
          orders.collect do |order_entry|
            if order_entry["side"] == type
              Cryptoexchange::Models::Order.new(price:  order_entry['price'],
                                                amount: order_entry['amount']
              )
            end 
          end.compact
        end
      end
    end
  end
end
