module Cryptoexchange::Exchanges
  module Vb
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(trades_url(market_pair))
          adapt(output['data'], market_pair)
        end

        def trades_url(market_pair)
          "#{Cryptoexchange::Exchanges::Vb::Market::API_URL}/orders?symbol=#{market_pair.inst_id}"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Vb::Market::NAME
            tr.type      = trade['type']
            tr.price     = trade['price']
            tr.amount    = trade['amount']
            tr.timestamp = trade['date']
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
