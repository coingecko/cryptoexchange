require 'byebug'
module Cryptoexchange::Exchanges
  module Bitsdaq
    module Services
      class OrderBook < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          buy = super(order_book_buy_url(market_pair))
          sell = super(order_book_sell_url(market_pair))
          adapt(buy, sell, market_pair)
        end

        def order_book_buy_url(market_pair)
          "#{Cryptoexchange::Exchanges::Bitsdaq::Market::API_URL}/order?orderType=BUY&marketSymbol=#{market_pair.base}-#{market_pair.target}&offset=0"
        end

        def order_book_sell_url(market_pair)
          "#{Cryptoexchange::Exchanges::Bitsdaq::Market::API_URL}/order?orderType=SELL&marketSymbol=#{market_pair.base}-#{market_pair.target}&offset=0"
        end

        def adapt(buy, sell, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new

          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Bitsdaq::Market::NAME
          order_book.asks      = adapt_orders(sell['result'])
          order_book.bids      = adapt_orders(buy['result'])
          order_book.payload   = buy['result'] + sell['result']
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order_entry|
            Cryptoexchange::Models::Order.new(price: NumericHelper.to_d(order_entry["price"]),
                                              amount: NumericHelper.to_d(order_entry["currentQuantity"]),
                                              timestamp: nil)
          end
        end
      end
    end
  end
end
