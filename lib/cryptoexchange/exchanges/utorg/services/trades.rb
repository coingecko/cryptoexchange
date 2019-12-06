module Cryptoexchange::Exchanges
  module Utorg
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(trades_url(market_pair))
          adapt(output, market_pair)
        end

        def trades_url(market_pair)
          inst_id = market_pair.inst_id
          "#{Cryptoexchange::Exchanges::Utorg::Market::API_URL}/market/#{inst_id}/trades"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['uuid']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.type      = trade['side'].downcase
            tr.price     = trade['price']
            tr.amount    = trade['amount']
            tr.timestamp = trade['matchedAt'] / 1000
            tr.payload   = trade
            tr.market    = Utorg::Market::NAME
            tr
          end
        end
      end
    end
  end
end
