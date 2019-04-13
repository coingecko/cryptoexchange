module Cryptoexchange::Exchanges
  module Oax
    module Services
      class Trades < Cryptoexchange::Services::Market
        HTTP_METHOD = 'POST'

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Oax::Market::API_URL}/market/getTrades?market=#{market_pair.base}/#{market_pair.target}"
        end

        def adapt(output, market_pair)
          output['data'].collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['id']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Oax::Market::NAME
            tr.type      = trade['type']
            tr.price     = trade['price']
            tr.amount    = trade['qty']
            tr.timestamp = trade['createTimeMs']/1000
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
