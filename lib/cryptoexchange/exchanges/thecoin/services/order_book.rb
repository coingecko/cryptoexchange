module Cryptoexchange::Exchanges
  module Thecoin
    module Services
      class OrderBook < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output['result'], market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Thecoin::Market::API_URL}/public/getorderbook?market=#{market_pair.base}-#{market_pair.target}&type=both "
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new

          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Thecoin::Market::NAME
          order_book.asks      = output['sell'].empty? ? ['Nil'] : adapt_orders(output['sell'])
          order_book.bids      = output['buy'].empty? ? ['Nil'] : adapt_orders(output['buy'])
          order_book.timestamp = Time.now.to_i
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order_entry|
            Cryptoexchange::Models::Order.new(price: order_entry['Rate'],
                                              amount: order_entry['Quantity'])
          end
        end
      end
    end
  end
end
