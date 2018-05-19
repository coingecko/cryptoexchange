module Cryptoexchange::Exchanges
  module BtcTradeUa
    module Services
      class OrderBook < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          sell_output = super(sell_url(market_pair))
          buy_output  = super(buy_url(market_pair))
          adapt(sell_output, buy_output, market_pair)
        end

        def sell_url(market_pair)
          base   = market_pair.base.downcase
          target = market_pair.target.downcase
          "#{Cryptoexchange::Exchanges::BtcTradeUa::Market::API_URL}/trades/sell/#{base}_#{target}"
        end

        def buy_url(market_pair)
          base   = market_pair.base.downcase
          target = market_pair.target.downcase
          "#{Cryptoexchange::Exchanges::BtcTradeUa::Market::API_URL}/trades/buy/#{base}_#{target}"
        end

        def adapt(sells, buys, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new

          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = BtcTradeUa::Market::NAME
          order_book.asks      = adapt_orders(sells['list'])
          order_book.bids      = adapt_orders(buys['list'])
          order_book.timestamp = Time.now.to_i
          order_book.payload   = [sells, buys]
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order_entry|
            price  = order_entry['price']
            amount = order_entry['currency_trade']
            Cryptoexchange::Models::Order.new(price:     price,
                                              amount:    amount)
          end
        end
      end
    end
  end
end
