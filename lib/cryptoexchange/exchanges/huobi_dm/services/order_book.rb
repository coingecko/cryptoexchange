  module Cryptoexchange::Exchanges
  module HuobiDm
    module Services
      class OrderBook < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = if market_pair.contract_interval == "perpetual"
            super(swap_order_book_url(market_pair))
          else
            super(order_book_url(market_pair))
          end
          adapt(output, market_pair)
        end

        def swap_order_book_url(market_pair)
          "#{Cryptoexchange::Exchanges::HuobiDm::Market::API_URL}/swap-ex/market/depth?contract_code=#{market_pair.inst_id}&type=step0"
        end

        def order_book_url(market_pair)
          "#{Cryptoexchange::Exchanges::HuobiDm::Market::API_URL}/market/depth?symbol=#{market_pair.inst_id}&type=step0"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new

          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = HuobiDm::Market::NAME
          order_book.asks      = adapt_orders(output['tick']['asks'])
          order_book.bids      = adapt_orders(output['tick']['bids'])
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order_entry|
            Cryptoexchange::Models::Order.new(price: NumericHelper.to_d(order_entry[0]),
                                              amount: NumericHelper.to_d(order_entry[1]),
                                              timestamp: nil)
          end
        end
      end
    end
  end
end
