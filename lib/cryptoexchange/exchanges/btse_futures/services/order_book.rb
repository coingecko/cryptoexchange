module Cryptoexchange::Exchanges
  module BtseFutures
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
          "#{Cryptoexchange::Exchanges::BtseFutures::Market::API_URL}/orderbook/#{market_pair.inst_id}"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new

          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = BtseFutures::Market::NAME
          order_book.asks      = adapt_orders output['sellQuote']
          order_book.bids      = adapt_orders output['buyQuote']
          order_book.timestamp = output['timestamp'].to_i / 1000
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |output|
            Cryptoexchange::Models::Order.new(price: output["price"],
                                              amount: output["size"],
                                              timestamp: nil)
          end
        end
      end
    end
  end
end
