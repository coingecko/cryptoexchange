module Cryptoexchange::Exchanges
  module Bitflip
    module Services
      class OrderBook < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          pair_combined = "#{market_pair.base.downcase}:#{market_pair.target.downcase}"
          raw_output = HTTP.post(orderbook_url, :body => "{\"pair\":\"#{pair_combined}\"}")
          output = JSON.parse(raw_output)
          adapt(output[1], market_pair)
        end

        def orderbook_url
          "#{Cryptoexchange::Exchanges::Bitflip::Market::API_URL}market.getOrderBook"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new
          timestamp = Time.now.to_i
          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Bitflip::Market::NAME
          order_book.asks      = adapt_orders(output['sell'])
          order_book.bids      = adapt_orders(output['buy'])
          order_book.timestamp = timestamp
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order_entry|
            Cryptoexchange::Models::Order.new(price: order_entry['price'],
                                              amount: order_entry['amount'],
                                              timestamp: nil)
          end
        end
      end
    end
  end
end
