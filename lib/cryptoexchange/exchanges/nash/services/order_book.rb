module Cryptoexchange::Exchanges
  module Nash
    module Services
      class OrderBook < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output["data"]["getOrderBook"], market_pair)
        end

        def ticker_url(market_pair)
          "https://app.nash.io/api/graphql?query=query%20GetOrderBook%20%7BgetOrderBook(marketName:%20%22#{market_pair.base.downcase}_#{market_pair.target.downcase}%22)%20%7BupdateId%20lastUpdateId%20bids%20%7Bprice%20%7Bamount%20currencyA%20currencyB%7D%20amount%20%7Bamount%20currency%7D%7D%20asks%20%7Bprice%20%7Bamount%20currencyA%20currencyB%7D%20amount%20%7Bamount%20currency%7D%7D%7D%7D"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new

          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Nash::Market::NAME
          order_book.asks      = adapt_orders(output['asks'])
          order_book.bids      = adapt_orders(output['bids'])
          order_book.timestamp = Time.now.to_i
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order_entry|
            Cryptoexchange::Models::Order.new(price: order_entry["price"]['amount'],
                                              amount: order_entry['amount']['amount'])
          end
        end
      end
    end
  end
end
