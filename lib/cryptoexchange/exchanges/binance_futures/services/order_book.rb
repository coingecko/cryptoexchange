module Cryptoexchange::Exchanges
  module BinanceFutures
    module Services
      class OrderBook < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          root_api_url = if market_pair.contract_interval == "perpetual"
            Cryptoexchange::Exchanges::BinanceFutures::Market::API_URL
          elsif market_pair.contract_interval == "futures"
            Cryptoexchange::Exchanges::BinanceFutures::Market::FUTURES_API_URL
          end
          output = super(order_book_url(root_api_url, market_pair))
          adapt(output, market_pair)
        end

        def order_book_url(root_api_url, market_pair)
          "#{root_api_url}/depth?symbol=#{market_pair.inst_id}&limit=500"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new

          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = BinanceFutures::Market::NAME
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
