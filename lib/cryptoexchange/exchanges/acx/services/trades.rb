module Cryptoexchange::Exchanges
  module Acx
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          market_key = [market_pair.base, market_pair.target].join.downcase
          "#{Cryptoexchange::Exchanges::Acx::Market::API_URL}/trades?market=#{market_key}"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['id']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.type      = trade['side'] # looks like there is a bug now - response is always null
            tr.price     = trade['price']
            tr.amount    = trade['volume']
            tr.timestamp = DateTime.parse(trade['created_at']).to_time.to_i
            tr.payload   = trade
            tr.market    = Acx::Market::NAME
            tr
          end
        end
      end
    end
  end
end
