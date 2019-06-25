module Cryptoexchange::Exchanges
  module Bcex
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          base   = market_pair.base
          target = market_pair.target
          "#{Cryptoexchange::Exchanges::Bcex::Market::API_URL}/rt/getTrades?token=#{base}&market=#{target}"
        end

        def adapt(output, market_pair)
          trades = output['data']
          trades.collect do |trade|
            tr           = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.trade_id  = nil
            tr.type      = trade['dominance'] == 1 ? "buy" : "sell"
            tr.price     = trade['price']
            tr.amount    = trade['amount']
            tr.timestamp = trade['sorting']
            tr.payload   = trade
            tr.market    = Bcex::Market::NAME
            tr
          end
        end
      end
    end
  end
end
