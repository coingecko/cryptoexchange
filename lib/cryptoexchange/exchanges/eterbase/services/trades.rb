module Cryptoexchange::Exchanges
  module Eterbase
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "https://api.eterbase.exchange/api/markets/33/trades?limit=100"
          "#{Cryptoexchange::Exchanges::Eterbase::Market::API_URL}/markets/#{market_pair.inst_id}/trades?limit=100"
        end

        def adapt(output, market_pair)

          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['id']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Eterbase::Market::NAME
            tr.type      = trade['side'] == 1 ? 'buy' : 'sell'
            tr.price     = trade['price']
            tr.amount    = trade['qty']
            tr.timestamp = nil
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
