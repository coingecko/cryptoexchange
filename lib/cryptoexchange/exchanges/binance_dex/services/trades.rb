module Cryptoexchange::Exchanges
  module BinanceDex
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(trades_url(market_pair))
          adapt(output, market_pair)
        end

        def trades_url(market_pair)
          "https://dex-asiapacific.binance.org/api/v1/trades?offset=0&limit=50&symbol=#{market_pair.base}_#{market_pair.target}"
        end

        def adapt(output, market_pair)
          output["trade"].collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['tradeId']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.type      = nil
            tr.price     = trade['price']
            tr.amount    = trade['quantity']
            tr.timestamp = (trade['time']/1000).to_i
            tr.payload   = trade
            tr.market    = BinanceDex::Market::NAME
            tr
          end
        end
      end
    end
  end
end
