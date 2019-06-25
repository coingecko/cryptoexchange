module Cryptoexchange::Exchanges
  module Satoexchange
    module Services
      class OrderBook < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          market_pair = Cryptoexchange::Exchanges::Satoexchange::Market.assign_inst_id(market_pair) if market_pair.inst_id.nil?
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Satoexchange::Market::API_URL}/get_market_orders/?market_id=#{market_pair.inst_id}"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new

          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Satoexchange::Market::NAME
          order_book.asks      = adapt_orders(output['sell_orders'])
          order_book.bids      = adapt_orders(output['buy_orders'])
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order_entry|
            Cryptoexchange::Models::Order.new(price: order_entry['price'],
                                              amount: order_entry['amount'],
                                              timestamp: nil)
          end
        end
      end
    end
  end
end
