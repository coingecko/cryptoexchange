module Cryptoexchange::Exchanges
  module BtseFutures
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::BtseFutures::Market::API_URL}/trades/#{market_pair.inst_id}"
        end

        def adapt(output, market_pair)
          output.map do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = BtseFutures::Market::NAME
            tr.trade_id  = trade['tradeId']
            tr.type      = trade['side']
            tr.price     = trade['price']
            tr.amount    = trade['size']
            tr.timestamp = trade['timestamp'].to_i / 1000
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
