module Cryptoexchange::Exchanges
  module Liqnet
    module Services
      class OrderBook < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          pair_id = IdFetcher.get_id(market_pair)
          output = super(ticker_url(pair_id))
          adapt(output, market_pair)
        end

        def ticker_url(pair_id)
          "#{Cryptoexchange::Exchanges::Liqnet::Market::API_URL}/marketOrderBook?id=#{pair_id}"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new
          order_book.base = market_pair.base
          order_book.target = market_pair.target
          order_book.market = Liqnet::Market::NAME
          order_book.asks = adapt_orders(output['asks'])
          order_book.bids = adapt_orders(output['bids'])
          order_book.timestamp = Time.now.to_i
          order_book.payload = output
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order_entry|
            Cryptoexchange::Models::Order.new(price: order_entry[0],
                                              amount: order_entry[1],
                                              timestamp: Time.now.to_i)
          end
        end
      end
    end
  end
end
