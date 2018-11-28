module Cryptoexchange::Exchanges
  module Mxc
    module Services
      class OrderBook < Cryptoexchange::Services::Market
        COUNT = 20

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
          "#{Cryptoexchange::Exchanges::Mxc::Market::API_URL}/data/depth?depth=#{COUNT}&market=#{base}_#{target}"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new

          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Mxc::Market::NAME
          order_book.asks      = adapt_orders(HashHelper.dig(output, 'data', 'asks'))
          order_book.bids      = adapt_orders(HashHelper.dig(output, 'data', 'bids'))
          order_book.timestamp = nil
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order_entry|
            Cryptoexchange::Models::Order.new(price:  order_entry['price'],
                                              amount: order_entry['quantity'])
          end
        end
      end
    end
  end
end
