module Cryptoexchange::Exchanges
  module KrakenFutures
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(trades_url(market_pair))
          adapt(output, market_pair)
        end

        def trades_url(market_pair)
          "#{Cryptoexchange::Exchanges::KrakenFutures::Market::API_URL}/history?symbol=#{market_pair.inst_id}"
        end

        def adapt(output, market_pair)
          output["history"].collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade["trade_id"]
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.type      = trade["side"]
            tr.price     = trade["price"]
            tr.amount    = trade["size"]
            tr.timestamp = Time.parse(trade["time"]).to_i
            tr.payload   = trade
            tr.market    = KrakenFutures::Market::NAME
            tr
          end
        end
      end
    end
  end
end
