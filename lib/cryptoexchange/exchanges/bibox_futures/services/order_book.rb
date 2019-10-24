module Cryptoexchange::Exchanges
  module BiboxFutures
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
          "#{Cryptoexchange::Exchanges::BiboxFutures::Market::API_URL}/mdata?cmd=depth&pair=#{market_pair.inst_id}"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new
          timestamp = Time.now.to_i
          depth = output['result']

          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = BiboxFutures::Market::NAME
          order_book.asks      = adapt_orders depth['asks']
          order_book.bids      = adapt_orders depth['bids']
          order_book.timestamp = timestamp
          order_book.payload   = depth
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
