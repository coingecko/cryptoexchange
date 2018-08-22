module Cryptoexchange::Exchanges
  module Rfinex
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "https://rfinex.com/markets/#{market_pair.base.downcase}#{market_pair.target.downcase}.json"
        end

        def adapt(output, market_pair)
          output['trades'].collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['tid']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Rfinex::Market::NAME
            tr.type      = trade['type']
            tr.price     = NumericHelper.to_d(trade['price'])
            tr.amount    = NumericHelper.to_d(trade['amount'])
            tr.timestamp = trade['date']
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
