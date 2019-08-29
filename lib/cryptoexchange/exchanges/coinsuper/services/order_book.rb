module Cryptoexchange::Exchanges
  module Coinsuper
    module Services
      class OrderBook < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          begin  
            step = get_step(market_pair)
            output = get_order_book(market_pair, step)
            adapt(output, market_pair)
          rescue
            #pair BXC/USDT can't fetch step  
            puts "#{market_pair.base}/#{market_pair.target} can't fetch step"
          end  
        end

        def get_order_book(market_pair, step)
          body = {"lang":"en-GB","language":"en-GB","community":"Coinsuper","data":{"source":"WEB","symbol":"#{market_pair.base.upcase}/#{market_pair.target.upcase}","stepName":"#{step}"}}.to_json
          res = HTTP.post("https://www.coinsuper.com/rest/quotation/v1/web/orderBook", body: body)
          output = JSON.parse(res.body)["data"]  
        end

        def get_step(market_pair)
          body = {"lang":"en-GB","language":"en-GB","community":"Coinsuper","data":{"source":"WEB","symbol":"#{market_pair.base.upcase}/#{market_pair.target.upcase}"}}.to_json
          res = HTTP.post("https://www.coinsuper.com/v1/order/symbol/symbolDetail", body: body)
          step = JSON.parse(res.body)["data"]["steps"][0]["code"]
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new

          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Coinsuper::Market::NAME
          order_book.asks      = adapt_orders(output['asks'])
          order_book.bids      = adapt_orders(output['bids'])
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order_entry|
            Cryptoexchange::Models::Order.new(price: NumericHelper.to_numeric(order_entry["limitPrice"]),
                                              amount: NumericHelper.to_numeric(order_entry["quantity"]))
          end
        end
      end
    end
  end
end
