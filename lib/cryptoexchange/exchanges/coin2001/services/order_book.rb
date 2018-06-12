module Cryptoexchange::Exchanges
  module Coin2001
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
          base   = market_pair.base
          target = market_pair.target
          "#{Cryptoexchange::Exchanges::Coin2001::Market::API_URL}/v1/public/getOrderBook?market=#{target}_#{base}&type=both"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new

          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Coin2001::Market::NAME
          order_book.asks      = adapt_orders HashHelper.dig(output, 'result', 'sell')
          order_book.bids      = adapt_orders HashHelper.dig(output, 'result', 'buy')
          order_book.timestamp = Time.now.to_i
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order_entry|
            Cryptoexchange::Models::Order.new(price:  order_entry['Rate'],
                                              amount: order_entry['Quantity']
            )
          end
        end
      end
    end
  end
end
