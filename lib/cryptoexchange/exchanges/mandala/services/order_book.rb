module Cryptoexchange::Exchanges
  module Mandala
    module Services
      class OrderBook < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          buyOutput = super(order_book_url(market_pair, "BUY"))
          sellOutput = super(order_book_url(market_pair, "SELL"))

          adapt(buyOutput, sellOutput, market_pair)
        end

        def order_book_url(market_pair, side)
          base = market_pair.base
          target = market_pair.target

          url = "#{Cryptoexchange::Exchanges::Mandala::Market::API_URL}/market/get-open-orders/#{target}_#{base}/#{side}/10/"

        end

        def adapt(buyOutput, sellOutput, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new
          timestamp = Time.now.to_i

          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Mandala::Market::NAME
          order_book.asks      = adapt_orders(sellOutput["data"], timestamp)
          order_book.bids      = adapt_orders(buyOutput["data"], timestamp)
          order_book.timestamp = timestamp
          order_book
        end

        def adapt_orders(orders, timestamp)
          if orders != nil
            if orders["status"] != "Error"
              o = orders["Orders"]
              o.collect do |order_entry|
                Cryptoexchange::Models::Order.new(price: NumericHelper.to_d(order_entry["Rate"].abs),
                                                  amount: NumericHelper.to_d(order_entry["Volume"]),
                                                  timestamp: timestamp)
              end
            end
          end
        end
      end
    end
  end
end
