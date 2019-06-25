module Cryptoexchange::Exchanges
  module Remitano
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(trades_url(market_pair))
          adapt(output, market_pair)
        end

        def trades_url(market_pair)
          base = market_pair.base
          target = market_pair.target
          "#{Cryptoexchange::Exchanges::Remitano::Market::API_URL}/markets/#{base}#{target}/trades"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = nil
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.type      = trade['type']
            tr.price     = trade['price']
            tr.amount    = trade['coin_amount']
            tr.timestamp = Time.parse(trade['timestamp']).to_i
            tr.payload   = trade
            tr.market    = Remitano::Market::NAME
            tr
          end
        end
      end
    end
  end
end
