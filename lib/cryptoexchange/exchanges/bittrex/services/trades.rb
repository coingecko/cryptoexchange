module Cryptoexchange::Exchanges
  module Bittrex
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(trades_url(market_pair))
          adapt(output, market_pair)
        end

        def trades_url(market_pair)
          base = market_pair.base
          target = market_pair.target
          "#{Cryptoexchange::Exchanges::Bittrex::Market::API_URL}/public/getmarkethistory?market=#{target}-#{base}"
        end

        def adapt(output, market_pair)
          output["result"].collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade["Id"]
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.type      = trade["OrderType"] == "BUY" ? "buy" : "sell"
            tr.price     = trade["Price"].to_f
            tr.amount    = trade["Quantity"].to_f
            tr.timestamp = DateTime.parse(trade["TimeStamp"]).to_time.utc.to_i
            tr.payload   = trade
            tr.market    = Bittrex::Market::NAME
            tr
          end
        end
      end
    end
  end
end
