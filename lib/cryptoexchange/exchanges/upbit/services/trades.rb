module Cryptoexchange::Exchanges
  module Upbit
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(trades_url(market_pair))
          adapt(output, market_pair)
        end
require 'byebug'
        def trades_url(market_pair)
          "#{Cryptoexchange::Exchanges::Upbit::Market::API_URL}/lines?code=CRIX.UPBIT.#{market_pair.target}-#{market_pair.base}"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            byebug
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['tid']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Upbit::Market::NAME
            tr.type      = trade['type']
            tr.price     = trade['price']
            tr.amount    = trade['amount']
            tr.timestamp = trade['date'].to_i
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
