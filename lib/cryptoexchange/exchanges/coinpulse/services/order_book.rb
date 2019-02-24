module Cryptoexchange::Exchanges
  module Coinpulse
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
          "#{Cryptoexchange::Exchanges::Coinpulse::Market::API_URL}/orderbook/#{market_pair.base}_#{market_pair.target}"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new

          result = if output.key?('result') then output['result'] else {} end
          asks = if result.key?('Ask') and !result['Ask'].to_a.empty? then result['Ask'] else [] end
          bids = if result.key?('Bid') and !result['Bid'].to_a.empty? then result['Bid'] else [] end

          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Coinpulse::Market::NAME
          order_book.asks      = unless asks.empty? then adapt_orders(asks) else nil end
          order_book.bids      = unless bids.empty? then adapt_orders(bids) else nil end
          order_book.timestamp = nil
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order_entry|
            amount = order_entry['Quantity']
            price = order_entry['Rate']
            Cryptoexchange::Models::Order.new(price: price,
                                              amount: amount,
                                              timestamp: nil)
          end
        end
      end
    end
  end
end
