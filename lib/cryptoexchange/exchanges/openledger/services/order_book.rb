module Cryptoexchange::Exchanges
  module Openledger
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
          "#{Cryptoexchange::Exchanges::Openledger::Market::API_URL}/orderbook?market=#{base}_#{target}"
        end

        def adapt(output, market_pair)
          order_book           = Cryptoexchange::Models::OrderBook.new
          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Openledger::Market::NAME
          order_book.asks      = adapt_orders(output['result'].first['Ask'])
          order_book.bids      = adapt_orders(output['result'].first['Bid'])
          order_book.timestamp = Time.now.to_i
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order_entry|
            price  = order_entry['Rate']
            amount = order_entry['Quantity']

            Cryptoexchange::Models::Order.new(
              price:  price,
              amount: amount
            )
          end
        end
      end
    end
  end
end
