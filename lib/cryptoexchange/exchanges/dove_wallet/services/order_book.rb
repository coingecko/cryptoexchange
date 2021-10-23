module Cryptoexchange::Exchanges
  module DoveWallet
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
          "#{Cryptoexchange::Exchanges::DoveWallet::Market::API_URL}/getorderbook?market=#{market_pair.target}-#{market_pair.base}&type=both"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new

          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = DoveWallet::Market::NAME
          order_book.asks      = adapt_orders(output['result']['sell'])
          order_book.bids      = adapt_orders(output['result']['buy'])
          order_book.timestamp = nil
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order_entry|
            Cryptoexchange::Models::Order.new(price: order_entry["Rate"],
                                              amount: order_entry["Quantity"])
          end
        end
      end
    end
  end
end
