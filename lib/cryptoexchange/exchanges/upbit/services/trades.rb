module Cryptoexchange::Exchanges
  module Upbit
    module Services
      class Trades < Cryptoexchange::Services::Market

        def fetch(market_pair)
          output = super(trades_url(market_pair))
          adapt(output, market_pair)
        end

        def trades_url(market_pair)
          "#{Cryptoexchange::Exchanges::Upbit::Market::API_URL}/trades/ticks?market=#{market_pair.base}-#{market_pair.target}&count=200"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['tid']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Upbit::Market::NAME
            tr.type      = trade['ask_bid'] == 'BID' ? 'buy' : 'sell'
            tr.price     = trade['trade_price']
            tr.amount    = trade['trade_volume']
            tr.timestamp = trade['timestamp']
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
