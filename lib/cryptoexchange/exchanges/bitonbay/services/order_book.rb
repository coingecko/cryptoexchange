module Cryptoexchange::Exchanges
  module Bitonbay
    module Services
      class OrderBook < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          output = sort(output)
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "https://www.bitonbay.com/api-public-orderbook0x0#{market_pair.base.downcase}#{market_pair.target.downcase}"
        end

        def sort(output)
          orders = Hash.new
          orders['asks'] = Array.new
          orders['bids'] = Array.new
            output.map do | order |
             order['order_type'] == 'b' ? orders['bids'].push(order) : orders['asks'].push(order)
            end
          orders
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new

          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Bitonbay::Market::NAME
          order_book.asks      = adapt_orders(output['asks'])
          order_book.bids      = adapt_orders(output['bids'])
          order_book.timestamp = Time.now.to_i
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order_entry|
            Cryptoexchange::Models::Order.new(price: order_entry['order_price'],
                                              amount: order_entry['order_amount'])
          end
        end
      end
    end
  end
end
