module Cryptoexchange::Exchanges
  module Bibo
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
          "#{Cryptoexchange::Exchanges::Bibo::Market::API_URL}/openApi/market/depth?symbol=#{market_pair.base}-#{market_pair.target}"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new
          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Bibo::Market::NAME
          order_book.asks      = adapt_orders output['result']['asks']
          order_book.bids      = adapt_orders output['result']['bids']
          order_book.timestamp = output['result']['ts'] / 1000
          order_book.payload   = output['result']
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
