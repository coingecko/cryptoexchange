module Cryptoexchange::Exchanges
  module Codex
    module Services
      class Trades < Cryptoexchange::Services::Market
        TRADES_LIMIT = 500
        FROM_TIME = (Time.now - 86400).to_i
        TO_TIME = Time.now.to_i

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output['trades'], market_pair)
        end

        def ticker_url(pair)
          "#{Cryptoexchange::Exchanges::Codex::Market::API_URL}/trades_history?market=#{pair.base}#{pair.target}&limit=#{TRADES_LIMIT}&from_time=#{FROM_TIME}&to_time=#{TO_TIME}"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr           = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['tid']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Codex::Market::NAME
            tr.type      = trade['side']
            tr.price     = trade['price']
            tr.amount    = trade['amount']
            tr.timestamp = trade['created_at'].to_i / 1000
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
