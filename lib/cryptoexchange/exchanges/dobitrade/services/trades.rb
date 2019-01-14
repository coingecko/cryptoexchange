module Cryptoexchange::Exchanges
  module Dobitrade
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output['data'], market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Dobitrade::Market::API_URL}/market/trades?market=#{market_pair.base.downcase}_#{market_pair.target.downcase}&limit=50"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Dobitrade::Market::NAME
            tr.type      = trade['s']
            tr.price     = trade['p']
            tr.amount    = trade['n']
            tr.timestamp = trade['t'].to_i/1000
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
