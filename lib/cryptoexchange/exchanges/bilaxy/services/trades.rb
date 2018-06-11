module Cryptoexchange::Exchanges
  module Bilaxy
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          id = market_pair.id
          "#{Cryptoexchange::Exchanges::Bilaxy::Market::API_URL}/orders?symbol=#{id}"
        end

        def adapt(output, market_pair)
          output['data'].collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = nil
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Bilaxy::Market::NAME
            tr.type      = trade["type"]
            tr.price     = trade["price"]
            tr.amount    = trade["amount"]
            tr.timestamp = trade["date"]
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
