module Cryptoexchange::Exchanges
  module Coinut
    module Services
      class Trades < Cryptoexchange::Services::Market
        include CoinutHelper

        def fetch(market_pair)
          output = prepare_and_send_request(market_pair.inst_id, false, true)
          adapt(output, market_pair)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Coinut::Market::API_URL}"
        end

        def adapt(output, market_pair)
          output["trades"].collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Coinut::Market::NAME
            tr.trade_id  = trade["trans_id"]
            tr.type      = trade["side"]
            tr.price     = trade["price"]
            tr.amount    = trade["qty"]
            tr.timestamp = trade["timestamp"]
            tr.payload   = trade
            tr
          end
        end
        
      end
    end
  end
end
