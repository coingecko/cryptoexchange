module Cryptoexchange::Exchanges
  module LocalBitcoins
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
          "#{Cryptoexchange::Exchanges::LocalBitcoins::Market::API_URL}/bitcoincharts/#{market_pair.target.downcase}/orderbook.json"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new

          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = LocalBitcoins::Market::NAME
          order_book.asks      = adapt_orders output['asks']
          order_book.bids      = adapt_orders output['bids']
          order_book.timestamp = Time.now.to_i
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order_entry|
            price, amount = order_entry
            # this amount is a ceiling amount of how much user can buy
            Cryptoexchange::Models::Order.new(price: price,
                                              amount: amount,
                                              timestamp: nil)
          end
        end
      end
    end
  end
end
