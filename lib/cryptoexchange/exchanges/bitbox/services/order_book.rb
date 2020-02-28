module Cryptoexchange::Exchanges
  module Bitbox
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
          "#{Cryptoexchange::Exchanges::Bitbox::Market::API_URL}/market/public/orderBooks?coinPair=#{market_pair.base.upcase}.#{market_pair.target.upcase}"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new
          output = output["responseData"]

          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Bitbox::Market::NAME
          order_book.asks      = adapt_orders(output['ASK'])
          order_book.bids      = adapt_orders(output['BID'])
          order_book.timestamp = nil
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order_entry|
            Cryptoexchange::Models::Order.new(price: order_entry["price"],
                                              amount: order_entry["amount"])
          end
        end
      end
    end
  end
end
