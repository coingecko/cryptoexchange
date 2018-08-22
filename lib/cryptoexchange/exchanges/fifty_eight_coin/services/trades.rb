module Cryptoexchange::Exchanges
  module FiftyEightCoin
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          response = super(trades_url(market_pair))
          adapt(response, market_pair)
        end

        def trades_url(market_pair)
          base   = market_pair.base.downcase
          target = market_pair.target.downcase
          "#{Cryptoexchange::Exchanges::FiftyEightCoin::Market::API_URL}/spot/trades?symbol=#{base}_#{target}"
        end

        def adapt(response, market_pair)
          response['result'].collect do |trade|
            tr           = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.trade_id  = nil
            tr.type      = trade[3]
            tr.price     = trade[1]
            tr.amount    = trade[2]
            tr.timestamp = trade[0]
            tr.payload   = trade
            tr.market    = FiftyEightCoin::Market::NAME
            tr
          end
        end
      end
    end
  end
end
