module Cryptoexchange::Exchanges
  module Btcbox
    module Services
      class OrderBook < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          raw_output = HTTP['user-agent' => 'curl/7.54.0'].get "#{ticker_url(market_pair)}"
          output = JSON.parse(raw_output)
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Btcbox::Market::API_URL}/depth/#{market_pair.base}"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new
          timestamp = Time.now.to_i
          
          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Btcbox::Market::NAME
          order_book.asks      = adapt_orders(output['asks'])
          order_book.bids      = adapt_orders(output['bids'])
          order_book.timestamp = timestamp
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order_entry|
            price, amount = order_entry
            Cryptoexchange::Models::Order.new(price: price,
                                              amount: amount,
                                              timestamp: nil)
          end
        end
      end
    end
  end
end
