module Cryptoexchange::Exchanges
  module Cashierest
    module Services
      class OrderBook < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          #because vcr doesn't use BOM
          if ENV["ENV"] = "test"
            output = super(ticker_url(market_pair))
          else
            encoding_options = {
              :invalid           => :replace,  # Replace invalid byte sequences
              :undef             => :replace,  # Replace anything not defined in ASCII
              :replace           => '',        # Use a blank for those replacements
              :universal_newline => true       # Always break lines with \n
            }
            output = HTTP.get(ticker_url(market_pair))
            output = JSON.parse(JSON.parse(output.to_json.encode(Encoding.find('ASCII'), encoding_options)))
          end
          adapt(output["ReturnData"], market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Cashierest::Market::API_URL}/OrderBook?PaymentCurrency=#{market_pair.target}&Coin=#{market_pair.base}&Count=50"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new
          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Cashierest::Market::NAME
          order_book.asks      = adapt_orders(output['Asks'])
          order_book.bids      = adapt_orders(output['Bids'])
          order_book.timestamp = output['CreateDate'].to_i / 1000
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order_entry|
            Cryptoexchange::Models::Order.new(price: order_entry["Price"].to_f,
                                              amount: order_entry["Quantity"].to_f)
          end
        end
      end
    end
  end
end
