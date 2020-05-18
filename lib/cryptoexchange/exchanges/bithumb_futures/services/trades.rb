module Cryptoexchange::Exchanges
  module BithumbFutures
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::BithumbFutures::Market::API_URL}/trades?symbol=#{market_pair.inst_id}"
        end

        def adapt(output, market_pair)
          output['data']['data'].collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = nil
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = BithumbFutures::Market::NAME
            tr.type      = trade['bm'] == true ? 'sell' : 'buy'
            tr.price     = trade['p']
            tr.amount    = trade['q']
            tr.timestamp = nil
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
