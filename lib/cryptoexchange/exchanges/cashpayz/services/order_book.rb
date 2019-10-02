module Cryptoexchange::Exchanges
  module Cashpayz
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
          "#{Cryptoexchange::Exchanges::Cashpayz::Market::API_URL}/depth/#{market_pair.target}/#{market_pair.base}"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new
          output               = output["data"][0]
          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Cashpayz::Market::NAME
          order_book.asks      = adapt_orders(output['ASK'])
          order_book.bids      = adapt_orders(output['Bid'])
          order_book.timestamp = nil
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order_entry|
            Cryptoexchange::Models::Order.new(price: order_entry[0].to_f,
                                              amount: order_entry[1].to_f)
          end
        end
      end
    end
  end
end
