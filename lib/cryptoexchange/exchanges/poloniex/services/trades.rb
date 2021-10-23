module Cryptoexchange::Exchanges
  module Poloniex
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(trades_url(market_pair))
          adapt(output, market_pair)
        end

        def trades_url(market_pair)
          base = market_pair.base
          target = market_pair.target
          "#{Cryptoexchange::Exchanges::Poloniex::Market::API_URL}?command=returnTradeHistory&currencyPair=#{target}_#{base}"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade["globalTradeID"]
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.type      = trade["type"]
            tr.price     = trade["rate"].to_f
            tr.amount    = trade["amount"].to_f
            tr.timestamp = DateTime.parse(trade["date"]).to_time.utc.to_i
            tr.payload   = trade
            tr.market    = Poloniex::Market::NAME
            tr
          end
        end
      end
    end
  end
end
