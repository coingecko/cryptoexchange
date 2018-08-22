module Cryptoexchange::Exchanges
  module Thinkbit
    module Services
      class Trades < Cryptoexchange::Services::Market

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Thinkbit::Market::API_URL}/deal/#{market_pair.base}_#{market_pair.target}?size=50"
        end

        def adapt(output, market_pair)
          output['data'].collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = nil
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Thinkbit::Market::NAME
            tr.type      = trade['side']
            tr.price     = trade['values'][0]
            tr.amount    = trade['values'][1]
            tr.timestamp = trade['time']/1000
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
