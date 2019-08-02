module Cryptoexchange::Exchanges
  module Probit
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
          "#{Cryptoexchange::Exchanges::Probit::Market::API_URL}/order_book?market_id=#{base}-#{target}"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new

          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Probit::Market::NAME
          order_book.asks      = arrange_orders(output['data'], "bids")
          order_book.bids      = arrange_orders(output['data'], "asks")
          order_book.timestamp = nil
          order_book.payload   = output
          order_book
        end

        def arrange_orders(orders, type)
          output = []
          if type == "bids"
            orders.map { |i| output << i if i["side"] == "buy" }
          elsif type == "asks"
            orders.map { |i| output << i if i["side"] == "sell" }
          end
          adapt_orders(output)
        end

        def adapt_orders(orders)
          orders.collect do |order_entry|
            Cryptoexchange::Models::Order.new(price:  order_entry["price"].to_f,
                                              amount: order_entry["quantity"].to_f)
          end
        end
      end
    end
  end
end
