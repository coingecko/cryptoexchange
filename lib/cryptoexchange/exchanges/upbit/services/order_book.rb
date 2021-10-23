module Cryptoexchange::Exchanges
  module Upbit
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
          "#{Cryptoexchange::Exchanges::Upbit::Market::API_URL}/orderbook?markets=#{market_pair.target.upcase}-#{market_pair.base.upcase}"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new

          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Upbit::Market::NAME
          order_book.asks      = adapt_orders(output[0]['orderbook_units'], 'ask')
          order_book.bids      = adapt_orders(output[0]['orderbook_units'], 'bid')
          order_book.timestamp = nil
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders, type)
          orders.collect do |order_entry|
            if type == 'ask'
              Cryptoexchange::Models::Order.new(price: order_entry['ask_price'],
                                              amount: order_entry['ask_size'],
                                              timestamp: nil)
            elsif type == 'bid'
              Cryptoexchange::Models::Order.new(price: order_entry['bid_price'],
                                              amount: order_entry['bid_size'],
                                              timestamp: nil)
            end
          end
        end
      end
    end
  end
end
