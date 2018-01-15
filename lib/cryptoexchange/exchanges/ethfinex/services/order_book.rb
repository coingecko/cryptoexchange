module Cryptoexchange::Exchanges
  module Ethfinex
    module Services
      class OrderBook < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          pre_output = super(order_book_url(market_pair))
          output = split(pre_output)
          adapt(output, market_pair)
        end

        def order_book_url(market_pair)
          "#{Cryptoexchange::Exchanges::Ethfinex::Market::API_URL}/v2/trades/t#{market_pair.base}#{market_pair.target}/hist"
        end

        def split(pre_output)
          output = [[], []] # output[0] = asks | output[1] = bids
          pre_output.map do |trade|
            if trade[2] < 0
              output[0].push(trade)
            else
            output[1].push(trade)
            end
          end
          output
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new
          timestamp = Time.now.to_i
          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Ethfinex::Market::NAME
          order_book.asks      = adapt_orders(output[0], timestamp)
          order_book.bids      = adapt_orders(output[1], timestamp)
          order_book.timestamp = timestamp
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders, timestamp)
          orders.collect do |order_entry|
            Cryptoexchange::Models::Order.new(price: NumericHelper.to_d(order_entry[-1]),
                                              amount: NumericHelper.to_d(order_entry[2].abs),
                                              timestamp: timestamp)
          end

        end
      end
    end
  end
end
