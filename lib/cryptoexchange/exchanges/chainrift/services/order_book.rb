module Cryptoexchange::Exchanges
  module Chainrift
    module Services
      class OrderBook < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output['data'], market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Chainrift::Market::API_URL}/Public/GetOrderBook?symbol=#{market_pair.base}/#{market_pair.target}"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new
          asks = output.select { |order| order['type'] == "Sell" }
          bids = output.select { |order| order['type'] == "Buy" }

          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Chainrift::Market::NAME
          order_book.asks      = adapt_orders(asks)
          order_book.bids      = adapt_orders(bids)
          order_book.timestamp = Time.now.to_i
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order_entry|
            Cryptoexchange::Models::Order.new(price: order_entry['price'],
                                              amount: order_entry['quantity'],
                                              timestamp: Time.now.to_i)
          end
        end
      end
    end
  end
end
