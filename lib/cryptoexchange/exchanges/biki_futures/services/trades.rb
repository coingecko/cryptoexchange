module Cryptoexchange::Exchanges
  module BikiFutures
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          base   = market_pair.base
          target = market_pair.target
          "#{Cryptoexchange::Exchanges::BikiFutures::Market::API_URL}/trades?instrumentID=#{market_pair.inst_id}"
        end

        def adapt(output, market_pair)
          output['data']['trades'].collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['tid']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = BikiFutures::Market::NAME
            tr.price     = trade['px']
            tr.amount    = trade['qty']
            tr.timestamp = Time.parse(trade['created_at']).to_i
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
