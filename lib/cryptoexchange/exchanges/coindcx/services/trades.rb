module Cryptoexchange::Exchanges
  module Coindcx
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Coindcx::Market::API_URL_2}/market_data/trade_history?pair=B-#{market_pair.base}_#{market_pair.target}"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.type      = trade['m'] == "false" ? "buy" : "sell"
            tr.price     = trade['p']
            tr.amount    = trade['q']
            tr.timestamp = trade['T'] / 1000
            tr.payload   = trade
            tr.market    = Coindcx::Market::NAME
            tr
          end
        end
      end
    end
  end
end
