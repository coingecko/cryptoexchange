module Cryptoexchange::Exchanges
  module Beaxy
    module Services
      class Trades < Cryptoexchange::Services::Market

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          inst_id   = market_pair.inst_id
          "#{Cryptoexchange::Exchanges::Beaxy::Market::API_URL}/Symbols/#{inst_id}/Trades"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr           = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.type      = trade['tsf'] == 0 ? "buy" : "sell"
            tr.price     = trade['p']
            tr.amount    = trade['s']
            tr.timestamp = trade['ts'] / 1000
            tr.payload   = trade
            tr.market    = Beaxy::Market::NAME
            tr
          end
        end
      end
    end
  end
end
