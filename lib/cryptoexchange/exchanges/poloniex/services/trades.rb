module Cryptoexchange::Exchanges
  module Poloniex
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Poloniex::Market::API_URL}?command=returnTradeHistory&currencyPair=#{market_pair.base}_#{market_pair.target}"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['tradeID']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.type      = trade['type']
            tr.price     = trade['rate']
            tr.amount    = trade['amount']
            tr.timestamp = DateTime.parse(trade['date']).to_time.to_i
            tr.payload   = trade
            tr.market    = Poloniex::Market::NAME
            tr
          end
        end
      end
    end
  end
end
