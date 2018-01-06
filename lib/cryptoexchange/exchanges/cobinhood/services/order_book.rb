module Cryptoexchange::Exchanges
  module Cobinhood
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
          trading_pair_id = "#{market_pair.base}-#{market_pair.target}"
          "#{Cryptoexchange::Exchanges::Cobinhood::Market::API_URL}/market/orderbooks/#{trading_pair_id}"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new
          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Cobinhood::Market::NAME
          order_book.asks      = adapt_orders output["result"]["orderbook"]['asks']
          order_book.bids      = adapt_orders output["result"]["orderbook"]['bids']
          order_book.timestamp = DateTime.now.to_time.to_i
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |price, amount, count|
            Cryptoexchange::Models::Order.new \
              price: price,
              amount: amount,
              timestamp: DateTime.now.to_time.to_i
          end
        end

        private

        def http_get(endpoint)
          ctx = OpenSSL::SSL::SSLContext.new
          ctx.verify_mode = OpenSSL::SSL::VERIFY_NONE
          fetch_response = HTTP.timeout(:write => 2, :connect => 5, :read => 8).get(endpoint, ssl_context: ctx)
        end

      end
    end
  end
end
