module Cryptoexchange::Exchanges
  module TraderOne
    module Services
      class OrderBook < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output['result'], market_pair)
        end

        def ticker_url(market_pair)
          market = "#{market_pair.base}-#{market_pair.target}"
          "#{Cryptoexchange::Exchanges::TraderOne::Market::API_URL}/markets/listOrderBook?market=#{market}"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new
          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = TraderOne::Market::NAME
          order_book.asks      = adapt_orders(output['sell'])
          order_book.bids      = adapt_orders(output['buy'])
          order_book.payload   = output
          order_book
          
        end

	def adapt_orders(orders)
          orders.map do |order_entry|
          	unitPrice = order_entry[0]
          	totalAmount = order_entry[1]
          	rateUSDC = order_entry[2]
          	flag = order_entry[3]
            
          	Cryptoexchange::Models::Order.new(price: unitPrice,
                          amount: totalAmount,
                          timestamp: nil)
        end
      end
    end
  end
 end
 end