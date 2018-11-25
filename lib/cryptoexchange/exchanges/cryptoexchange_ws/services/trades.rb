module Cryptoexchange::Exchanges
  module CryptoexchangeWs
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = fetch_using_post(ticker_url(market_pair), {"market": "#{market_pair.base}-#{market_pair.target}", "count": 50})
          adapt(output['results'], market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::CryptoexchangeWs::Market::API_URL}/public/lastTrades"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = CryptoexchangeWs::Market::NAME
            tr.type      = trade['type'] == 1 ? 'buy' : 'sell'
            tr.price     = trade['rate']
            tr.amount    = trade['nominal']
            tr.timestamp = trade['time']/1000
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
