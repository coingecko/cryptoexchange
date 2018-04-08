module Cryptoexchange::Exchanges
  module Rightbtc
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(trades_url(market_pair))
          adapt(output['result'], market_pair)
        end

        def trades_url(market_pair)
          "#{Cryptoexchange::Exchanges::Rightbtc::Market::API_URL}/trades/#{market_pair.base}#{market_pair.target}"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['tid']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Rightbtc::Market::NAME
            tr.type      = trade['side'].downcase
            tr.price     = trade['price']
            tr.amount    = trade['amount']
            tr.timestamp = Time.now.to_i
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
