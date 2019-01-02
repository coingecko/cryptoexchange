module Cryptoexchange::Exchanges
  module Ddex
    module Services
      class Trades < Cryptoexchange::Services::Market

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output['data']['trades'], market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Ddex::Market::API_URL}/markets/#{market_pair.base}-#{market_pair.target}/trades"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['id']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Ddex::Market::NAME
            tr.price     = trade['price']
            tr.amount    = trade['amount']
            tr.timestamp = trade['executedAt'].to_i
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
