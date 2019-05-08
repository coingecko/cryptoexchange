module Cryptoexchange::Exchanges
  module Quoine
    module Services
      class OrderBook < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          pairs = Cryptoexchange::Exchanges::Quoine::Services::Pairs.new.fetch
          selected_pair = pairs.select { |p| p.base == market_pair.base && p.target == market_pair.target }.first

          output = super(order_book_url(selected_pair))
          adapt(output, selected_pair)
        end

        def order_book_url(market_pair)
          "#{Cryptoexchange::Exchanges::Quoine::Market::API_URL}/products/#{market_pair.inst_id}/price_levels?full=1"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new

          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Quoine::Market::NAME
          order_book.asks      = adapt_orders(output['sell_price_levels'])
          order_book.bids      = adapt_orders(output['buy_price_levels'])
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order_entry|
            Cryptoexchange::Models::Order.new(price: NumericHelper.to_d(order_entry[0]),
                                              amount: NumericHelper.to_d(order_entry[1]),
                                              timestamp: nil)
          end
        end
      end
    end
  end
end
