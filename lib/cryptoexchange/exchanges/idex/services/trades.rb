module Cryptoexchange::Exchanges
  module Idex
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          params = {}
          params['market'] = "#{market_pair.target}_#{market_pair.base}"
          output = fetch_using_post(ticker_url, params)
          adapt(output, market_pair)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Idex::Market::API_URL}/returnTradeHistory"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['uuid']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.type      = trade['type']
            tr.price     = trade['price']
            tr.amount    = trade['amount']
            tr.timestamp = trade['timestamp']
            tr.payload   = trade
            tr.market    = Idex::Market::NAME
            tr
          end
        end
      end
    end
  end
end
