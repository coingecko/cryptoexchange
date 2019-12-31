module Cryptoexchange::Exchanges
  module Bilaxy
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Bilaxy::Market::API_URL}/trades?pair=#{market_pair.base}_#{market_pair.target}"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['id']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Bilaxy::Market::NAME
            tr.type      = trade["direction"]
            tr.price     = trade["price"]
            tr.amount    = trade["amount"]
            tr.timestamp = trade["ts"] / 1000
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
