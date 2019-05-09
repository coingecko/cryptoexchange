module Cryptoexchange::Exchanges
  module Chaoex
    module Services
      class OrderBook < Cryptoexchange::Services::Market
        ORDER_BOOK_LIMIT = "50"

        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          pairs = Cryptoexchange::Exchanges::Chaoex::Services::Pairs.new.fetch
          pair = pairs.select { |pair| pair.base == market_pair.base && pair.target == market_pair.target }.first
          output = super(ticker_url(pair))
          adapt(output, market_pair)
        end

        def ticker_url(pair)
          base_id, target_id = pair.inst_id.split("-")
          "#{Cryptoexchange::Exchanges::Chaoex::Market::API_URL}/quote/tradeDeepin?baseCurrencyId=#{target_id}&tradeCurrencyId=#{base_id}&limit=#{ORDER_BOOK_LIMIT}"
        end

        def adapt(output, market_pair)
          order_book           = Cryptoexchange::Models::OrderBook.new
          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Chaoex::Market::NAME
          order_book.asks      = adapt_orders output['attachment']['asks']
          order_book.bids      = adapt_orders output['attachment']['bids']
          order_book.timestamp = Time.now.to_i
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order_entry|
            price, amount = order_entry
            Cryptoexchange::Models::Order.new(
              price:     price,
              amount:    amount,
              timestamp: nil
            )
          end
        end
      end
    end
  end
end
