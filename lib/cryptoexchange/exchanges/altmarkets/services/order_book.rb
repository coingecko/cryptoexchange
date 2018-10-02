module Cryptoexchange::Exchanges
  module Altmarkets
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
          "#{Cryptoexchange::Exchanges::Altmarkets::Market::API_URL}/public/getorderbook?market=#{target}-#{base}&type=both"
        end

        def adapt(output, market_pair)
          data       = output['result']
          order_book = Cryptoexchange::Models::OrderBook.new

          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Altmarkets::Market::NAME
          order_book.asks      = adapt_orders(data['sell'])
          order_book.bids      = adapt_orders(data['buy'])
          order_book.timestamp = nil
          order_book.payload   = data
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order_entry|
            Cryptoexchange::Models::Order.new(price:  order_entry['Rate'],
                                              amount: order_entry['Quantity'])
          end
        end
      end
    end
  end
end
