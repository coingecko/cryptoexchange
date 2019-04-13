module Cryptoexchange::Exchanges
  module Chainex
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Chainex::Market::API_URL}/market/trades/#{market_pair.base}/#{market_pair.target}/200"
        end

        def adapt(output, market_pair)
          output['data'].collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = nil
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Chainex::Market::NAME
            tr.type      = trade['type'].downcase
            tr.price     = trade['price']
            tr.amount    = trade['amount']
            tr.timestamp = trade['time'].to_i.floor
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
