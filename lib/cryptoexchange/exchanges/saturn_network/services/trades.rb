module Cryptoexchange::Exchanges
  module SaturnNetwork
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::SaturnNetwork::Market::API_URL}/api/v2/trades/#{market_pair.target}/#{market_pair.base}/#{ether_address}/all.json"
        end

        def adapt(output, market_pair)
          output["buys"].concat(output["sells"]).collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade["id"]
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = SaturnNetwork::Market::NAME
            tr.type      = trade["order_type"].downcase
            tr.price     = trade["price"].to_f
            tr.amount    = trade_amount(trade).to_f
            tr.timestamp = trade["created_at"].to_i
            tr.payload   = trade
            tr
          end
        end

        private

        def trade_amount(trade)
          if trade["order_type"] == "BUY"
            trade["buytokenamount"]
          else
            trade["selltokenamount"]
          end
        end

        def ether_address
          "0x0000000000000000000000000000000000000000"
        end
      end
    end
  end
end
