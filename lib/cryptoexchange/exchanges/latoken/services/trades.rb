module Cryptoexchange::Exchanges
  module Latoken
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(trades_url(market_pair))
          adapt(output, market_pair)
        end

        def trades_url(market_pair)
          "#{Cryptoexchange::Exchanges::Latoken::Market::API_URL}/trade/history/#{market_pair.base}/#{market_pair.target}"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.type      = trade["direction"] == "TRADE_DIRECTION_BUY" ? 'buy' : 'sell'
            tr.price     = trade["price"]
            tr.amount    = trade["quantity"]
            tr.timestamp = trade["timestamp"]/1000
            tr.payload   = trade
            tr.market    = Latoken::Market::NAME
            tr
          end
        end
      end
    end
  end
end
