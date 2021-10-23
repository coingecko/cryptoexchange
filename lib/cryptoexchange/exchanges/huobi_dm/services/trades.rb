module Cryptoexchange::Exchanges
  module HuobiDm
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = if market_pair.contract_interval == "perpetual"
            super(swap_trades_url(market_pair))
          else
            super(trades_url(market_pair))
          end
          adapt(output, market_pair)
        end

        def swap_trades_url(market_pair)
          "#{Cryptoexchange::Exchanges::HuobiDm::Market::API_URL}/swap-ex/market/history/trade?contract_code=#{market_pair.inst_id}&size=2000"
        end

        def trades_url(market_pair)
          "#{Cryptoexchange::Exchanges::HuobiDm::Market::API_URL}/market/history/trade?symbol=#{market_pair.inst_id}&size=2000"
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
            tr.market    = HuobiDm::Market::NAME
            tr
          end
        end
      end
    end
  end
end
