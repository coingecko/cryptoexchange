module Cryptoexchange::Exchanges
  module Coinone
    module Services
      class Trades < Cryptoexchange::Services::Market
        TYPE = {
          "up" => "buy",
          "down" => "sell"
        }.freeze

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          base = market_pair.base.downcase

          "#{Cryptoexchange::Exchanges::Coinone::Market::API_URL}/trades/?currency=#{base}"
        end

        def adapt(output, market_pair)
          trades = output['completeOrders']

          trades.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = market_pair.market
            tr.price     = trade['price']
            tr.amount    = trade['qty']
            tr.timestamp = trade['timestamp'].to_i
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
