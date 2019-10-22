module Cryptoexchange::Exchanges
  module Raidofinance
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
          "#{Cryptoexchange::Exchanges::Raidofinance::Market::API_URL}/orderbook/#{market_pair.base.upcase}#{market_pair.target.upcase}/0"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new
          timestamp = Time.now.to_i

          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Raidofinance::Market::NAME
          order_book.asks      = adapt_orders(output['data']['sell'])
          order_book.bids      = adapt_orders(output['data']['buy'])
          order_book.timestamp = timestamp
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |price, order_entry|
            Cryptoexchange::Models::Order.new(price: price,
                                              amount: order_entry[0])
          end
        end
      end
    end
  end
end
