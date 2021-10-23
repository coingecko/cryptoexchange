module Cryptoexchange::Exchanges
  module Unnamed
    module Services
      class Trades < Cryptoexchange::Services::Market

        def fetch(market_pair)
          output = super(trades_url(market_pair))
          adapt(output, market_pair)
        end

        def trades_url(market_pair)
          "#{Cryptoexchange::Exchanges::Unnamed::Market::API_URL}/TradeHistory?market=#{market_pair.base.upcase}_#{market_pair.target.upcase}"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['tradeId']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Unnamed::Market::NAME
            tr.type      = trade['type'] == 'Buy' ? 'buy' : 'sell'
            tr.price     = trade['price']
            tr.amount    = trade['amount']
            tr.timestamp = trade['timestamp']
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
