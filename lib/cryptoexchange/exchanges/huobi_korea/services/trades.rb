module Cryptoexchange::Exchanges
  module HuobiKorea
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(trades_url(market_pair))
          adapt(output, market_pair)
        end

        def trades_url(market_pair)
          base = market_pair.base.downcase
          target = market_pair.target.downcase
          "#{Cryptoexchange::Exchanges::HuobiKorea::Market::API_URL}/market/history/trade?symbol=#{base}#{target}&size=2000"
        end

        def adapt(output, market_pair)
          output["data"].collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade["data"][0]["id"]
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.type      = trade["data"][0]["direction"]
            tr.price     = trade["data"][0]["price"].to_f
            tr.amount    = trade["data"][0]["amount"].to_f
            tr.timestamp = trade["data"][0]["ts"] / 1000
            tr.payload   = trade
            tr.market    = HuobiKorea::Market::NAME
            tr
          end
        end
      end
    end
  end
end
