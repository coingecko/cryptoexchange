module Cryptoexchange::Exchanges
  module IndependentReserve
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
          "#{Cryptoexchange::Exchanges::IndependentReserve::Market::API_URL}/GetOrderBook?primaryCurrencyCode=#{market_pair.base.downcase}&secondaryCurrencyCode=#{market_pair.target.downcase}"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new
          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = IndependentReserve::Market::NAME
          order_book.asks      = adapt_orders(output['SellOrders'])
          order_book.bids      = adapt_orders(output['BuyOrders'])
          order_book.timestamp = nil
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order_entry|
            Cryptoexchange::Models::Order.new(price: order_entry["Price"].to_f,
                                              amount: order_entry["Volume"].to_f,
                                              timestamp: nil)
          end
        end
      end
    end
  end
end
