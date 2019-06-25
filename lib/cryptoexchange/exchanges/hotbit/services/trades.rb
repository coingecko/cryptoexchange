module Cryptoexchange::Exchanges
  module Hotbit
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(trades_url(market_pair))
          adapt(output, market_pair)
        end

        def trades_url(market_pair)
          base = market_pair.base
          target = market_pair.target
          "#{Cryptoexchange::Exchanges::Hotbit::Market::API_URL}/market.deals?market=#{base}/#{target}&limit=1000&last_id=0"
        end

        def adapt(output, market_pair)
          output["result"].collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade["id"]
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.type      = trade["type"]
            tr.price     = trade["price"].to_f
            tr.amount    = trade["amount"].to_f
            tr.timestamp = trade["time"].to_i
            tr.payload   = trade
            tr.market    = Hotbit::Market::NAME
            tr
          end
        end
      end
    end
  end
end
