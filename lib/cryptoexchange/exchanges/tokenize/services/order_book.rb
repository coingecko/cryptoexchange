module Cryptoexchange::Exchanges
  module Tokenize
    module Services
      class OrderBook < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          buy_output = JSON.parse(HTTP.get(buy_ticker_url(market_pair)))
          sell_output = JSON.parse(HTTP.get(sell_ticker_url(market_pair)))
          output = { asks: sell_output["data"]["orders"], bids: buy_output["data"]["orders"] }
          adapt(output, market_pair)
        end

        def buy_ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Tokenize::Market::API_URL}/market/get-buy-orders?market=#{market_pair.target.upcase}-#{market_pair.base.upcase}"
        end

        def sell_ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Tokenize::Market::API_URL}/market/get-sell-orders?market=#{market_pair.target.upcase}-#{market_pair.base.upcase}"
        end        

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new

          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Tokenize::Market::NAME
          order_book.asks      = adapt_orders output[:asks]
          order_book.bids      = adapt_orders output[:bids]
          order_book.timestamp = nil
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order|
            Cryptoexchange::Models::Order.new(
              price:  order["rate"],
              amount: order["quantity"]
            )
          end
        end
      end
    end
  end
end
