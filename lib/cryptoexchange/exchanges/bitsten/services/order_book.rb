module Cryptoexchange::Exchanges
  module Bitsten
    module Services
      class OrderBook < Cryptoexchange::Services::Market
        LIMIT = 100
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
          "#{Cryptoexchange::Exchanges::Bitsten::Market::API_URL}/public/getorderbook/#{base}_#{target}/both/#{LIMIT}"
        end

        def adapt(output, market_pair)
          order_book           = Cryptoexchange::Models::OrderBook.new
          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Bitsten::Market::NAME
          order_book.asks      = adapt_orders(HashHelper.dig(output, 'result', 'selllimit'))
          order_book.bids      = adapt_orders(HashHelper.dig(output, 'result', 'buylimit'))
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order_entry|
            Cryptoexchange::Models::Order.new(price:     order_entry['price'],
                                              amount:    order_entry['amount'],
                                              timestamp: nil)
          end
        end
      end
    end
  end
end
