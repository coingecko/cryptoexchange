module Cryptoexchange::Exchanges
  module Blockonix
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Blockonix::Market::API_URL}/marketData/trades/?#{market_pair.inst_id}&tradeCount=100"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['tradeId']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Blockonix::Market::NAME
            tr.type      = trade['mode']
            tr.price     = trade['price']
            tr.amount    = trade['qty']
            tr.timestamp = trade['timestamp'].to_i
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
