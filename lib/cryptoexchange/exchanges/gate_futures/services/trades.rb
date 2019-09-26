module Cryptoexchange::Exchanges
  module GateFutures
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(trades_url(market_pair))
          adapt(output, market_pair)
        end

        def trades_url(market_pair)
          "#{Cryptoexchange::Exchanges::GateFutures::Market::API_URL}/trades?contract=#{market_pair.inst_id}"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr           = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.type      = trade['size'].to_f < 0 ? "sell" : "buy"
            tr.price     = trade['price'].to_f
            tr.amount    = trade['size'].to_f
            tr.timestamp = trade['create_time']
            tr.trade_id  = trade['id']
            tr.payload   = trade
            tr.market    = GateFutures::Market::NAME
            tr
          end
        end
      end
    end
  end
end
