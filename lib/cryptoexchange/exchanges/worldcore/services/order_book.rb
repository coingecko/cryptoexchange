module Cryptoexchange::Exchanges
  module Worldcore
    module Services
      class OrderBook < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          raw_output = HTTP.headers("Content-Type" => "application/x-www-form-urlencoded").post(ticker_url, :body => "pair=#{market_pair.base.downcase}_#{market_pair.target.downcase}" )
          output = JSON.parse(raw_output)
          adapt(output['result'], market_pair)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Worldcore::Market::API_URL}/market/panel"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new

          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Worldcore::Market::NAME
          order_book.asks      = adapt_orders(output['book_sell'])
          order_book.bids      = adapt_orders(output['book_buy'])
          order_book.timestamp = output['time']/1000
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order_entry|
            Cryptoexchange::Models::Order.new(price: order_entry['price'],
                                              amount: order_entry['amount'])
          end
        end
      end
    end
  end
end
