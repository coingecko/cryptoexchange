module Cryptoexchange::Exchanges
  module Coinlink
    module Services
      class OrderBook < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          secret_header = Digest::SHA256.hexdigest(market_pair.base+'APTEST1bot_key')
          raw_output = HTTP.headers(:SecretHeader => secret_header).get(ticker_url(market_pair))
          output = JSON.parse(raw_output)
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Coinlink::Market::API_URL}/orderbook?currency=#{market_pair.base}&lineArr=AP&apiKey=TEST1"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new
          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Coinlink::Market::NAME
          order_book.asks      = adapt_orders(output['data']['asks'], output['data']['timestamp']) 
          order_book.bids      = adapt_orders(output['data']['bids'], output['data']['timestamp'])
          order_book.timestamp = output['data']['timestamp']
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders, timestamp)
          orders.collect do |order_entry|
            Cryptoexchange::Models::Order.new(price: order_entry['it_market_cost'],
                                              amount: order_entry['nResCoin'],
                                              timestamp: timestamp)
          end
        end
      end
    end
  end
end
