module Cryptoexchange::Exchanges
  module Waves
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
          symbols = Cryptoexchange::Exchanges::Waves::Market.fetch_symbol
          base    = symbols.detect { |s| s[1] == market_pair.base }[0]
          target  = symbols.detect { |s| s[1] == market_pair.target }[0] || "WAVES"

          "https://matcher.waves.exchange/matcher/orderbook/#{base}/#{target}"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new

          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Waves::Market::NAME
          order_book.asks      = adapt_orders(output['asks'])
          order_book.bids      = adapt_orders(output['bids'])
          order_book.timestamp = nil
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order_entry|
            Cryptoexchange::Models::Order.new(
              price: order_entry["price"].to_f / 1000000,
              amount: order_entry["amount"].to_f / 100000000
            )
          end
        end
      end
    end
  end
end
