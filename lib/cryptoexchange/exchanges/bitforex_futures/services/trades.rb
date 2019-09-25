module Cryptoexchange::Exchanges
  module BitforexFutures
    module Services
      class Trades < Cryptoexchange::Services::Market

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "https://www.bitforex.com/contract/mkapi/trades?businessType=#{market_pair.inst_id}&size=50"
        end

        def adapt(output, market_pair)
          output["data"].collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['tid']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = BitforexFutures::Market::NAME
            tr.type      = trade['direction'] == 1 ? "buy" : "sell"
            tr.price     = trade['price']
            tr.amount    = trade['amount']
            tr.timestamp = trade['time'].to_i / 1000
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
