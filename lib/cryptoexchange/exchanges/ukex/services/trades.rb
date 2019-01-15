module Cryptoexchange::Exchanges
  module Ukex
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Ukex::Market::API_URL}/tradeHistory/#{market_pair.base.downcase}_#{market_pair.target.downcase}"
        end

        def adapt(output, market_pair)
          output['data'].collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['tradeID']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Ukex::Market::NAME
            tr.type      = trade['type']
            tr.price     = trade['rate']
            tr.amount    = trade['amount']
            tr.timestamp = DateTime.parse(trade['date']).to_time.to_i
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
