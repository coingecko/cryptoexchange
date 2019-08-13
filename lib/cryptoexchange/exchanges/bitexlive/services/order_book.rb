module Cryptoexchange::Exchanges
  module Bitexlive
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
          "https://bitexlive.com/api/orders?symbol=BTC_LTC"
          "#{Cryptoexchange::Exchanges::Bitexlive::Market::API_URL}/orders?symbol=#{market_pair.target}_#{market_pair.base}"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new
          output = output["Data"]

          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Bitexlive::Market::NAME
          order_book.asks      = adapt_orders output['SELL']
          order_book.bids      = adapt_orders output['BUY']
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order_entry|
            Cryptoexchange::Models::Order.new(
              price:     order_entry["Price"].to_f,
              amount:    order_entry["Quantity"].to_f,
              timestamp: nil
            )
          end
        end
      end
    end
  end
end
