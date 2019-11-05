module Cryptoexchange::Exchanges
  module Elitex
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output["data"], market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Elitex::Market::API_URL}/public/#{market_pair.base.upcase}_#{market_pair.target.upcase}/trade"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['id']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Elitex::Market::NAME
            tr.type      = trade['side']
            tr.price     = trade['price']
            tr.amount    = trade['amount']
            tr.timestamp = nil
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
