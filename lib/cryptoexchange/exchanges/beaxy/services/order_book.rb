module Cryptoexchange::Exchanges
  module Beaxy
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
          inst_id   = market_pair.inst_id
          "#{Cryptoexchange::Exchanges::Beaxy::Market::API_URL}/Symbols/#{inst_id}/OrderBook"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new

          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Beaxy::Market::NAME
          order_book.asks      = adapt_orders(output['sell'])
          order_book.bids      = adapt_orders(output['buy'])
          order_book.timestamp = nil
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order_entry|
            Cryptoexchange::Models::Order.new(price:     order_entry['p'],
                                              amount:    order_entry['s'],
                                              timestamp: order_entry['ts']/1000)
          end
        end
      end
    end
  end
end
