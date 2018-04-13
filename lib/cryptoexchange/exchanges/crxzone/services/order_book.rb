module Cryptoexchange::Exchanges
  module Crxzone
    module Services
      class OrderBook < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          result = IdFetcher.get_id(market_pair.base.upcase, market_pair.target.upcase)
          if result.length > 0
            pair = result.first
            pair_id = pair["ID"]
            output = super(order_book_url(pair_id))
            adapt(output["Result"], market_pair)
          end
        end

        def order_book_url(pair_id)
          "#{Cryptoexchange::Exchanges::Crxzone::Market::API_URL}/Market_Depth?currencyPairID=#{pair_id}"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new
          timestamp = output["TimeStamp"]
          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Crxzone::Market::NAME
          order_book.asks      = adapt_orders(output["Asks"], timestamp)
          order_book.bids      = adapt_orders(output["Bids"], timestamp)
          order_book.timestamp = timestamp
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders, timestamp)
          orders.collect do |order_entry|
            Cryptoexchange::Models::Order.new(price: NumericHelper.to_d(order_entry[0]),
                                              amount: NumericHelper.to_d(order_entry[1]),
                                              timestamp: timestamp)
          end
        end
      end
    end
  end
end
