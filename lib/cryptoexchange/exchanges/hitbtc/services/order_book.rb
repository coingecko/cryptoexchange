module Cryptoexchange::Exchanges
  module Hitbtc
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
          "#{Cryptoexchange::Exchanges::Hitbtc::Market::API_URL}/public/orderbook/#{market_pair.base}#{market_pair.target}"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new

          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Hitbtc::Market::NAME
          order_book.asks      = output['ask'].empty? ? ['Nil'] : adapt_orders(output['ask'])
          order_book.bids      = output['bid'].empty? ? ['Nil'] : adapt_orders(output['bid'])
          order_book.timestamp = DateTime.parse(output['timestamp']).to_time.to_i
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order_entry|
            Cryptoexchange::Models::Order.new(price: order_entry['price'],
                                              amount: order_entry['size'])
          end
        end
      end
    end
  end
end
