module Cryptoexchange::Exchanges
  module BhexFutures
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::BhexFutures::Market::API_URL}/contract/trades?symbol=#{market_pair.inst_id}"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.type      = trade['isBuyerMaker'] ? "sell" : "buy"
            tr.price     = NumericHelper.to_d(trade['price'])
            tr.amount    = NumericHelper.to_d(trade['qty'])
            tr.timestamp = trade['time'] / 1000
            tr.payload   = trade
            tr.market    = BhexFutures::Market::NAME
            tr
          end
        end
      end
    end
  end
end
