module Cryptoexchange::Exchanges
  module Bilaxy
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
          pairs = Cryptoexchange::Exchanges::Bilaxy::Services::Pairs.new.fetch
          pair = pairs.select { |p| p.base == market_pair.base && p.target == market_pair.target }.first
          id = pair.id
          "#{Cryptoexchange::Exchanges::Bilaxy::Market::API_URL}/depth?symbol=#{id}&merge=4"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new

          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Bilaxy::Market::NAME
          order_book.asks      = adapt_orders(HashHelper.dig(output, 'data', 'asks'))
          order_book.bids      = adapt_orders(HashHelper.dig(output, 'data', 'bids'))
          order_book.timestamp = Time.now.to_i
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders)
          # cuz the output is the string, so need to get back to array first
          orders.collect do |order_entry|
            Cryptoexchange::Models::Order.new(price:  order_entry[0],
                                              amount: order_entry[1]
            )
          end
        end
      end
    end
  end
end
