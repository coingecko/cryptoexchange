module Cryptoexchange::Exchanges
  module Drgx
    module Services
      class Trades < Cryptoexchange::Services::Market

        def fetch(market_pair)
          output = super(trades_url(market_pair))
          adapt(output, market_pair)
        end

        def trades_url(market_pair)
          "#{Cryptoexchange::Exchanges::Drgx::Market::API_URL}/TradesCm?pair=#{market_pair.base.downcase}_#{market_pair.target.downcase}"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr           = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['tradeID']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Drgx::Market::NAME
            tr.type      = trade['type']
            tr.price     = trade['price']
            tr.amount    = trade['base_volume']
            tr.timestamp = trade['trade_timestamp']
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
