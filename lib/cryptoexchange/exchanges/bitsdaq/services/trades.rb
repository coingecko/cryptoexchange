module Cryptoexchange::Exchanges
  module Bitsdaq
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(trades_url(market_pair))
          adapt(output, market_pair)
        end

        def trades_url(market_pair)
          base = market_pair.base.upcase
          target = market_pair.target.upcase
          "#{Cryptoexchange::Exchanges::Bitsdaq::Market::API_URL}/order/matchedOrder?marketSymbol=#{base}-#{target}&size=50"
        end

        def adapt(output, market_pair)
          output["result"].collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.type      = trade["OrderType"] == "BUY" ? "buy" : "sell"
            tr.price     = trade["price"].to_f
            tr.amount    = trade["matchedQuantity"].to_f
            tr.timestamp = trade["createdAt"].to_i / 1000
            tr.payload   = trade
            tr.market    = Bitsdaq::Market::NAME
            tr
          end
        end
      end
    end
  end
end
