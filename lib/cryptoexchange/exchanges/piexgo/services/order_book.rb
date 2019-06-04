module Cryptoexchange::Exchanges
  module Piexgo
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
          market_pair = "#{market_pair.base.upcase}_#{market_pair.target.upcase}"
          "#{Cryptoexchange::Exchanges::Piexgo::Market::API_URL}/api/v1/orderBook?symbol=#{market_pair}"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new
          order_book.base = market_pair.base
          order_book.target = market_pair.target
          order_book.market = Piexgo::Market::NAME

          order_book.asks = adapt_orders(output['asks'])
          order_book.bids = adapt_orders(output['bids'])
          order_book.timestamp = output["ts"].to_i
          order_book.payload = output
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order_entry|
            Cryptoexchange::Models::Order.new(price: order_entry['price'],
                                              amount: order_entry['volume'],
                                              timestamp: nil)
          end
        end
      end
    end
  end
end
