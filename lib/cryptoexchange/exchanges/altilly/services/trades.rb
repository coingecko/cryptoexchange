module Cryptoexchange::Exchanges
  module Altilly
    module Services
      class Trades < Cryptoexchange::Services::Market

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Altilly::Market::API_URL}/public/trades/#{market_pair.base}#{market_pair.target}?sort=DESC&by=timestamp&limit=100"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['id']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Altilly::Market::NAME
            tr.type      = trade['side']
            tr.price     = trade['price']
            tr.amount    = trade['quantity']
            tr.timestamp = trade['unixtimestamp']
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
