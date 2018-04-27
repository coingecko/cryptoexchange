module Cryptoexchange::Exchanges
  module Dsx
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
          base = market_pair.base.downcase
          target = market_pair.target.downcase
          "#{Cryptoexchange::Exchanges::Dsx::Market::API_URL}/depth/#{base}#{target}/"
        end

        def adapt(output, market_pair)
          data = output["#{market_pair.base.downcase}#{market_pair.target.downcase}"]
          order_book = Cryptoexchange::Models::OrderBook.new

          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Dsx::Market::NAME
          order_book.asks      = adapt_orders data['asks']
          order_book.bids      = adapt_orders data['bids']
          order_book.timestamp = Time.now.to_i
          order_book.payload   = data
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order_entry|
            price, amount = order_entry
            Cryptoexchange::Models::Order.new(
              price: price,
              amount: amount,
              timestamp: nil
            )
          end
        end
      end
    end
  end
end
