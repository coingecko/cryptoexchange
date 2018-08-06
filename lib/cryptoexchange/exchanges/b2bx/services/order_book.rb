module Cryptoexchange::Exchanges
  module B2bx
    module Services
      class OrderBook < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          raw_output = HTTP.use(:auto_inflate).headers("Accept-Encoding" => "gzip").get(ticker_url(market_pair))
          output = JSON.parse(raw_output)
          adapt(output['Ticks'][-1], market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::B2bx::Market::API_URL}/public/quotehistory/#{market_pair.base}#{market_pair.target}/level2?timestamp=#{((DateTime.now - (1/1440.0)).strftime('%Q')).to_i}&count=100"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new

          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = B2bx::Market::NAME
          order_book.asks      = adapt_orders(output['Asks'])
          order_book.bids      = adapt_orders(output['Bids'])
          order_book.timestamp = output['Timestamp']/1000
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order_entry|
            Cryptoexchange::Models::Order.new(price: order_entry['Price'],
                                              amount: order_entry['Volume'])
          end
        end
      end
    end
  end
end
