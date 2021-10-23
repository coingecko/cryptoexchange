module Cryptoexchange::Exchanges
  module DexBlue
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
          "#{Cryptoexchange::Exchanges::DexBlue::Market::API_URL}/market/#{market_pair.base.upcase}#{market_pair.target.upcase}/orderbook"
        end

        def adapt(output, market_pair)
          decimal = Cryptoexchange::Exchanges::DexBlue::Market.get_decimal(market_pair.base)
          order_book = Cryptoexchange::Models::OrderBook.new

          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = DexBlue::Market::NAME
          order_book.asks      = adapt_orders(output['data'], "SELL", decimal)
          order_book.bids      = adapt_orders(output['data'], "BUY", decimal)
          order_book.timestamp = nil
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders, type, decimal)
          orders.collect do |order_entry|
            if order_entry["direction"] == type
              Cryptoexchange::Models::Order.new(
                price:  order_entry['rate'].to_f,
                amount: order_entry['amount'].to_f / decimal
              )
            end
          end.compact
        end
      end
    end
  end
end
