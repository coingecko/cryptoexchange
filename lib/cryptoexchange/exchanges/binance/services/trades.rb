module Cryptoexchange::Exchanges
  module Binance
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(trades_url(market_pair))
          adapt(output, market_pair)
        end

        def trades_url(market_pair)
          base = market_pair.base
          target = market_pair.target
          "#{Cryptoexchange::Exchanges::Binance::Market::API_URL}/trades?symbol=#{base}#{target}"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['id']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.type      = trade['isBuyerMaker'] ? "sell" : "buy"
            tr.price     = trade['price']
            tr.amount    = trade['qty']
            tr.timestamp = (trade['time']/1000).to_i
            tr.payload   = trade
            tr.market    = Binance::Market::NAME
            tr
          end
        end
      end
    end
  end
end
