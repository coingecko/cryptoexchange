module Cryptoexchange::Exchanges
  module Latoken
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(trades_url(market_pair))
          adapt(output, market_pair)
        end

        def trades_url(market_pair)
          "#{Cryptoexchange::Exchanges::Latoken::Market::API_URL}/MarketData/trades/#{market_pair.base}#{market_pair.target}/100"
        end

        def adapt(output, market_pair)
          output["trades"].collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.type      = trade["side"]
            tr.price     = trade["price"]
            tr.amount    = trade["amount"]
            tr.timestamp = trade["timestamp"] / 1000
            tr.payload   = trade
            tr.market    = Latoken::Market::NAME
            tr
          end
        end
      end
    end
  end
end
