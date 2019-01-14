module Cryptoexchange::Exchanges
  module Tokenmom
    module Services
      class Trades < Cryptoexchange::Services::Market

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output['trades'], market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Tokenmom::Market::API_URL}/market/get_trades?market_id=#{market_pair.base}-#{market_pair.target}"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['id']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Tokenmom::Market::NAME
            tr.price     = trade['price']
            tr.amount    = trade['amount']
            tr.timestamp = trade['updated_at'].to_i
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
