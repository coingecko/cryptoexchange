module Cryptoexchange::Exchanges
  module Joyso
    module Services
      class OrderBook < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          # Obtain base token no. to call for OrderBook. Target always = ETH
          base_token = IdFetcher.get_id(market_pair.base.upcase)
          output = super(order_book_url(base_token))
          adapt(output, market_pair)
        end

        def order_book_url(base_token)
          # ETH token no. = 0000000000000000000000000000000000000000
          "#{Cryptoexchange::Exchanges::Joyso::Market::API_URL}/orders?locale=en&contract=04f062809b244e37e7fdc21d9409469c989c2342&base=0000000000000000000000000000000000000000&token=#{base_token}"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new
          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Joyso::Market::NAME
          order_book.asks      = output["sell"].empty? ? ["nil"] : adapt_orders(output["sell"])
          order_book.bids      = output["buy"].empty? ? ["nil"] : adapt_orders(output["buy"])
          order_book.timestamp = Time.now.to_i
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order_entry|
            Cryptoexchange::Models::Order.new(price: NumericHelper.to_d(order_entry[0]),
                                              amount: NumericHelper.to_d(order_entry[1]),
                                              timestamp: Time.now.to_i)
          end
        end
      end
    end
  end
end
