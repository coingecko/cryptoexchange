module Cryptoexchange::Exchanges
  module Qbtc
    module Services
      class OrderBook < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          raw_output = HTTP.post(ticker_url(market_pair))
          output = JSON.parse(raw_output)
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Qbtc::Market::API_URL}/depthTable.do?tradeMarket=#{market_pair.target}&symbol=#{market_pair.base}"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new
          order_book.base = market_pair.base
          order_book.target = market_pair.target
          order_book.market = Qbtc::Market::NAME
          order_book.asks = adapt_orders(output['result']['sell'])
          order_book.bids = adapt_orders(output['result']['buy'])
          order_book.timestamp = Time.now.to_i
          order_book.payload = output
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order_entry|
            Cryptoexchange::Models::Order.new(price: order_entry['price'],
                                              amount: order_entry['amount'],
                                              timestamp: Time.now.to_i)
          end
        end
      end
    end
  end
end
