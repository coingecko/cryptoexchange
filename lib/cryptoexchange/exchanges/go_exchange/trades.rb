module Cryptoexchange::Exchanges
  module GoExchange
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::GoExchange::Market::API_URL}/exchange/trades/#{market_pair.base.upcase}#{market_pair.target.upcase}"
        end

        def adapt(output, market_pair)
          output["result"].collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['id']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.type      = trade['side']
            tr.price     = trade['price']
            tr.amount    = trade['amount']
            tr.timestamp = DateTime.parse(trade['timestamp']).to_time.to_i
            tr.payload   = trade
            tr.market    = GoExchange::Market::NAME
            tr
          end
        end
      end
    end
  end
end
