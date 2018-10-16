module Cryptoexchange::Exchanges
  module Vaultmex
    module Services
      class OrderBook < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          base       = market_pair.base
          target     = market_pair.target
          bid_output = super(bid_url(base, target))
          ask_output = super(ask_url(base, target))

          adapt(bid_output, ask_output, market_pair)
        end

        def bid_url(base, target)
          "#{Cryptoexchange::Exchanges::Vaultmex::Market::API_URL}/market/orders/#{base}/#{target}/BUY"
        end

        def ask_url(base, target)
          "#{Cryptoexchange::Exchanges::Vaultmex::Market::API_URL}/market/orders/#{base}/#{target}/SELL"
        end

        def adapt(bid_output, ask_output, market_pair)
          order_book           = Cryptoexchange::Models::OrderBook.new
          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Vaultmex::Market::NAME
          order_book.asks      = adapt_orders(ask_output['orders'])
          order_book.bids      = adapt_orders(bid_output['orders'])
          order_book.timestamp = nil
          order_book.payload   = { bid: bid_output, ask: ask_output }
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order_entry|
            Cryptoexchange::Models::Order.new(price:  order_entry['price'],
                                              amount: order_entry['amount'])
          end
        end
      end
    end
  end
end