module Cryptoexchange::Exchanges
  module Heat
    module Services
      class OrderBook < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          base, target = IdFetcher.get_id(market_pair.base.upcase, market_pair.target.upcase)
          asks = super(asks_url(base, target))
          bids = super(bids_url(base, target))
          adapt(asks, bids, market_pair)
        end

        def asks_url(base, target)
          "#{Cryptoexchange::Exchanges::Heat::Market::API_URL}/order/pair/asks/#{target.to_i}/#{base.to_i}/0/100"
        end

        def bids_url(base, target)
          "#{Cryptoexchange::Exchanges::Heat::Market::API_URL}/order/pair/bids/#{target.to_i}/#{base.to_i}/0/100"
        end

        def adapt(asks, bids, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new
          order_book.base = market_pair.base
          order_book.target = market_pair.target
          order_book.market = Heat::Market::NAME
          order_book.asks = adapt_orders(asks)
          order_book.bids = adapt_orders(bids)
          order_book.timestamp = Time.now.to_i
          order_book.payload = {asks: asks, bids: bids}
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order_entry|
            Cryptoexchange::Models::Order.new(price: order_entry['price'],
                                              amount: order_entry['quantity'],
                                              timestamp: Time.now.to_i)
          end
        end
      end
    end
  end
end
