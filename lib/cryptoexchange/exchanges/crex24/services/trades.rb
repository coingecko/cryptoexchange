module Cryptoexchange::Exchanges
  module Crex24
    module Services
      class Trades < Cryptoexchange::Services::Market
        COUNTS = 1000

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Crex24::Market::API_URL}/recentTrades?instrument=#{market_pair.base}-#{market_pair.target}"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = nil
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Crex24::Market::NAME
            tr.type      = trade['side']
            tr.price     = trade['price']
            tr.amount    = trade['volume']
            tr.timestamp = Time.parse(trade['timestamp']).to_i
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
