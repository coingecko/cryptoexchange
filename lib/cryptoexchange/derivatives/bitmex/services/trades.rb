# Disable Trades for Bitmex for now

module Cryptoexchange::Exchanges
  module Bitmex
    module Services
      class Trades < Cryptoexchange::Services::Market

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Bitmex::Market::API_URL}/trade?symbol=#{market_pair.inst_id}&reverse=true"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['trdMatchID']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Bitmex::Market::NAME
            tr.type      = trade['side'].downcase
            tr.price     = trade['price']
            tr.amount    = trade['size']
            tr.timestamp = Time.parse(trade['timestamp']).to_i
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
