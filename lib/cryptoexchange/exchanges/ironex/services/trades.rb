module Cryptoexchange::Exchanges
  module Coinhub
    module Services
      class Trades < Cryptoexchange::Services::Market

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Coinhub::Market::API_URL}/coinhub/public/trades?pair=#{market_pair.base}-#{market_pair.target}"
        end

        def adapt(output, market_pair)
          output['results'].collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['id']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Coinhub::Market::NAME
            tr.type      = trade['type']
            tr.price     = trade['price']
            tr.amount    = trade['amount']
            tr.timestamp = trade['timestamp'].to_i
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
