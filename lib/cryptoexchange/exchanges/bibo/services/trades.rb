module Cryptoexchange::Exchanges
  module Bibo
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(trades_url(market_pair))
          adapt(output, market_pair)
        end

        def trades_url(market_pair)
          "#{Cryptoexchange::Exchanges::Bibo::Market::API_URL}/openApi/market/trade?symbol=#{market_pair.base}-#{market_pair.target}"
        end

        def adapt(output, market_pair)
          output['result']['data'].collect do |trade|
            tr           = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.trade_id  = trade['id']
            tr.type      = trade['direction']
            tr.price     = NumericHelper.to_d trade['price']
            tr.amount    = NumericHelper.to_d trade['amount']
            tr.timestamp = trade['ts']
            tr.payload   = trade
            tr.market    = Bibo::Market::NAME
            tr
          end
        end
      end
    end
  end
end
