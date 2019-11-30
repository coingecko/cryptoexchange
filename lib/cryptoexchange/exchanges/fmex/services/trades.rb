module Cryptoexchange::Exchanges
  module Fmex
    module Services
      class Trades < Cryptoexchange::Services::Market

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output['data'], market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Fmex::Market::API_URL}/market/trades/#{market_pair.inst_id}?limit=500"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['id']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.type      = trade['side']
            tr.price     = trade['price']
            tr.amount    = trade['amount']
            tr.timestamp = trade['ts'] / 1000
            tr.payload   = trade
            tr.market    = Fmex::Market::NAME
            tr
          end
        end
      end
    end
  end
end
