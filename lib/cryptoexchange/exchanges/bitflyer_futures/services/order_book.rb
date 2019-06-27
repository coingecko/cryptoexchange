module Cryptoexchange::Exchanges
  module BitflyerFutures
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
          interval_code = Cryptoexchange::Exchanges::BitflyerFutures::Market::INTERVAL_CODE_LIST[market_pair.contract_interval]
          if market_pair.contract_interval == "perpetual"
            product_code = "#{interval_code}_#{market_pair.base}_#{market_pair.target}"
          else
            product_code = "#{market_pair.base}#{market_pair.target}_#{interval_code}"
          end

          "#{Cryptoexchange::Exchanges::BitflyerFutures::Market::API_URL}/board?product_code=#{product_code}"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new

          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = BitflyerFutures::Market::NAME
          order_book.asks      = adapt_orders(output['asks'])
          order_book.bids      = adapt_orders(output['bids'])
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order_entry|
            Cryptoexchange::Models::Order.new(price: NumericHelper.to_d(order_entry["price"]),
                                              amount: NumericHelper.to_d(order_entry["size"]),
                                              timestamp: nil)
          end
        end
      end
    end
  end
end
