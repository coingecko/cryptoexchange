module Cryptoexchange::Exchanges
  module Bitlish
    module Services
      class Trades < Cryptoexchange::Services::Market

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output['list'], market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Bitlish::Market::API_URL}/trades_history?pair_id=#{market_pair.base.downcase}#{market_pair.target.downcase}"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Bitlish::Market::NAME
            tr.type      = trade['dir'] == "ask" ? "sell" : "buy"
            tr.price     = trade['price']
            tr.amount    = trade['amount']
            tr.timestamp = trade['created']/1000000
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
