module Cryptoexchange::Exchanges
  module Okex
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Okex::Market::API_URL}/instruments/#{market_pair.base.upcase}-#{market_pair.target.upcase}/trades"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['trade_id']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.type      = trade['side']
            tr.price     = trade['price']
            tr.amount    = trade['size']
            tr.timestamp = Time.new(trade['timestamp']).to_i
            tr.payload   = trade
            tr.market    = Okex::Market::NAME
            tr
          end
        end
      end
    end
  end
end
