module Cryptoexchange::Exchanges
  module Ionomy
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          base   = market_pair.base
          target = market_pair.target
          "#{Cryptoexchange::Exchanges::Ionomy::Market::API_URL}/public/market-history?market=#{target}-#{base}"
        end

        def adapt(output, market_pair)
          output['data'].collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = nil
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Ionomy::Market::NAME
            tr.type      = (trade['type'].include? "_BUY") ? "buy" : "sell"
            tr.price     = trade['price']
            tr.amount    = trade['amount']
            tr.timestamp = DateTime.parse(trade['createdAt']).to_time.to_i
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
