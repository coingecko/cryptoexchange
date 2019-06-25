module Cryptoexchange::Exchanges
  module Biki
    module Services
      class OrderBook < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          pairs = Cryptoexchange::Exchanges::Biki::Services::Market.new.fetch
          pair = pairs.select { |p| p.base == market_pair.base && p.target == market_pair.target }.first
          output = super(order_book_url(pair))
          adapt(output, market_pair)
        end

        def order_book_url(market_pair)
          "#{Cryptoexchange::Exchanges::Biki::Market::API_URL}/market_dept?symbol=#{market_pair.base.downcase}#{market_pair.target.downcase}&type=step0"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new

          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Biki::Market::NAME
          order_book.asks      = adapt_orders(output['data']['tick']['asks'])
          order_book.bids      = adapt_orders(output['data']['tick']['bids'])
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
