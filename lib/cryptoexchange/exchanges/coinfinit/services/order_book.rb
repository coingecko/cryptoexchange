module Cryptoexchange::Exchanges
  module Coinfinit
    module Services
      class OrderBook < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          output = super(ticker_url)
          adapt_all(output)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Coinfinit::Market::API_URL}/orderbook"
        end

        def adapt_all(output)
          output.map do |pair, order_book|
            target, base = pair.split("_")
            market_pair = Cryptoexchange::Models::MarketPair.new(
                            base: base,
                            target: target,
                            market: Coinfinit::Market::NAME
                          )
            adapt(order_book, market_pair)
          end
        end        

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new

          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Coinfinit::Market::NAME
          order_book.asks      = adapt_orders(output['buy'])
          order_book.bids      = adapt_orders(output['sell'])
          order_book.timestamp = nil
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order_entry|
            Cryptoexchange::Models::Order.new(price: order_entry[0],
                                              amount: order_entry[1])
          end
        end
      end
    end
  end
end
