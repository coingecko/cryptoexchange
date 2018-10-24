module Cryptoexchange::Exchanges
  module Kairex
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
          "#{Cryptoexchange::Exchanges::Kairex::Market::API_URL}/market/orderbook?quote=#{market_pair.target}&base=#{market_pair.base}"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new

          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Kairex::Market::NAME
          order_book.asks      = adapt_orders output['ask']
          order_book.bids      = adapt_orders output['bid']
          order_book.timestamp = nil
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order_entry|
            Cryptoexchange::Models::Order.new(price: order_entry['price'],
                                              amount: order_entry['sumAmount'],
                                              timestamp: nil)
          end
        end
      end
    end
  end
end
