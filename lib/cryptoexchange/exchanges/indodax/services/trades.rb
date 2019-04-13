module Cryptoexchange::Exchanges
  module Indodax
    module Services
      class Trades < Cryptoexchange::Services::Market

        def fetch(market_pair)
          output = super(trade_url(market_pair))
          adapt(output, market_pair)
        end

        def trade_url(market_pair)
          base   = market_pair.base.downcase
          target = market_pair.target.downcase
          "#{Cryptoexchange::Exchanges::Indodax::Market::API_URL}/#{base}_#{target}/trades"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr           = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['tid']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Indodax::Market::NAME
            tr.type      = trade['type']
            tr.price     = trade['price']
            tr.amount    = trade['amount']
            tr.timestamp = trade['date'].to_i
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
