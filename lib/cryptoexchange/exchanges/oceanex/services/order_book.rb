module Cryptoexchange::Exchanges
  module Oceanex
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
          base   = market_pair.base.downcase
          target = market_pair.target.downcase
          "#{Cryptoexchange::Exchanges::Oceanex::Market::API_URL}/order_book?market=#{base}#{target}"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new

          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Oceanex::Market::NAME
          order_book.asks      = adapt_orders(output['data']['asks'])
          order_book.bids      = adapt_orders(output['data']['bids'])
          order_book.timestamp = NumericHelper.to_d(output['data']['timestamp'])
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order_entry|
            price, amount = order_entry
            Cryptoexchange::Models::Order.new(price:  price.to_f,
                                              amount: amount.to_f)
          end
        end
      end
    end
  end
end
