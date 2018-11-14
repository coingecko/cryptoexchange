module Cryptoexchange::Exchanges
    module Cointeb
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
            "#{Cryptoexchange::Exchanges::Cointeb::Market::API_URL}/bid_price/#{market_pair.target}-#{market_pair.base}"
          end
  
          def adapt(output, market_pair)
            order_book = Cryptoexchange::Models::OrderBook.new
            timestamp = Time.now.to_i
            order_book.base      = market_pair.base
            order_book.target    = market_pair.target
            order_book.market    = Coinzest::Market::NAME
            order_book.asks      = adapt_orders(output['bid_price']['askList'])
            order_book.bids      = adapt_orders(output['bid_price']['bidList'])
            order_book.timestamp = timestamp
            order_book.payload   = output
            order_book
          end
  
          def adapt_orders(orders)
            orders.collect do |order_entry|
              Cryptoexchange::Models::Order.new(price: order_entry['price'],
                                                amount: order_entry['quantity'],
                                                timestamp: nil)
            end
          end
        end
      end
    end
  end
  