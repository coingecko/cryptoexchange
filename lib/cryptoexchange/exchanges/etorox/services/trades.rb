module Cryptoexchange::Exchanges
  module Etorox
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Etorox::Market::API_URL}/#{market_pair.inst_id}/trades"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade["id"]
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Etorox::Market::NAME
            tr.price     = trade["price"]
            tr.amount    = trade["volume"]
            tr.timestamp = Time.new(trade["timestamp"]).to_i
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
