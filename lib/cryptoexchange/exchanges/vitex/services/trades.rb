module Cryptoexchange::Exchanges
  module Vitex
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Vitex::Market::API_URL}/trades?symbol=#{market_pair.base.upcase}_#{market_pair.target.upcase}"
        end

        def adapt(output, market_pair)
          output["data"]["trade"].collect do |trade|
            tr           = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['tradeId']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.type      = trade["side"] == 0 ? "buy" : "sell"
            tr.price     = trade['price']
            tr.amount    = trade['amount']
            tr.timestamp = trade['time']
            tr.payload   = trade
            tr.market    = Vitex::Market::NAME
            tr
          end
        end
      end
    end
  end
end
