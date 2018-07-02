module Cryptoexchange::Exchanges
  module Myspeedtrade
    module Services
      class OrderBook < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          ctx = OpenSSL::SSL::SSLContext.new
          ctx.verify_mode = OpenSSL::SSL::VERIFY_NONE
          result = HTTP.get(ticker_url(market_pair), ssl_context: ctx)
          output = JSON.parse(result)
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Myspeedtrade::Market::API_URL}/order_book?market=#{market_pair.base.downcase}#{market_pair.target.downcase}"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new
          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Myspeedtrade::Market::NAME
          order_book.asks      = output['asks'].empty? ? ['nil'] : adapt_orders(output['asks'])
          order_book.bids      = output['bids'].empty? ? ['nil'] : adapt_orders(output['bids'])
          order_book.timestamp = Time.now.to_i
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order_entry|
            Cryptoexchange::Models::Order.new(price: order_entry['price'],
                                              amount: order_entry['volume'],
                                              timestamp: nil)
          end
        end
      end
    end
  end
end
