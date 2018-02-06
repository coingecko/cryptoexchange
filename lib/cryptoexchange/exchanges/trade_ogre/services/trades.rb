module Cryptoexchange::Exchanges
  module TradeOgre
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::TradeOgre::Market::API_URL}/history/#{market_pair.target}-#{market_pair.base}"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.type      = trade['type']
            tr.price     = trade['price']
            tr.amount    = trade['quantity']
            tr.timestamp = trade['date']
            tr.payload   = trade
            tr.market    = TradeOgre::Market::NAME
            tr
          end
        end
      end
    end
  end
end
