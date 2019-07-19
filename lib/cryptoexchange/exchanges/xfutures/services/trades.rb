module Cryptoexchange::Exchanges
  module Xfutures
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Xfutures::Market::API_URL}/spot/v3/instruments/#{market_pair.inst_id}/trades"
        end

        def adapt(output, market_pair)
          output.map do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Xfutures::Market::NAME

            tr.trade_id  = trade["trade_id"]
            tr.type      = trade["side"]
            tr.price     = trade["price"]
            tr.amount    = trade["size"]
            tr.timestamp = DateTime.parse(trade["timestamp"]).to_time.to_i
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
