module Cryptoexchange::Exchanges
  module Neraex
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
          target = market_pair.target.downcase
          "#{Cryptoexchange::Exchanges::Neraex::Market::API_URL}/trades?market=#{base}#{target}"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['id']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Neraex::Market::NAME
            tr.type      = TYPE[trade['side']]
            tr.price     = trade['price']
            tr.amount    = trade['funds']
            tr.timestamp = trade['at']
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
