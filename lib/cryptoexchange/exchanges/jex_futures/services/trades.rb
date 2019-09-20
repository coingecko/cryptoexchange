module Cryptoexchange::Exchanges
  module JexFutures
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::JexFutures::Market::API_URL}/contract/trades?symbol=#{market_pair.base}#{market_pair.target}"
        end


        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = nil
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.type      = nil
            tr.price     = trade['price']
            tr.amount    = trade['qty']
            tr.timestamp = trade['time'] / 1000
            tr.payload   = trade
            tr.market    = JexFutures::Market::NAME
            tr
          end
        end
      end
    end
  end
end
