module Cryptoexchange::Exchanges
  module Worldcore
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Worldcore::Market::API_URL}/history/trade?pair=#{market_pair.base.downcase}_#{market_pair.target.downcase}"
        end

        def adapt(output, market_pair)
          output['result']['items'].collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['record_id']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Worldcore::Market::NAME
            tr.type      = trade['record_type']
            tr.price     = trade['price']
            tr.amount    = trade['amount']
            tr.timestamp = trade['created_at']/1000
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
