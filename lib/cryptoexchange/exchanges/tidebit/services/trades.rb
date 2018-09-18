module Cryptoexchange::Exchanges
  module Tidebit
    module Services
      class Trades < Cryptoexchange::Services::Market

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Tidebit::Market::API_URL}/trades.json?market=#{market_pair.base.downcase}#{market_pair.target.downcase}&limit=50&order_by=desc"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['id']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Tidebit::Market::NAME
            tr.type      = trade['side'] == 'up' ? 'buy' : 'sell'
            tr.price     = trade['price']
            tr.amount    = trade['volume']
            tr.timestamp = DateTime.parse(trade['created_at']).to_time.to_i
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
