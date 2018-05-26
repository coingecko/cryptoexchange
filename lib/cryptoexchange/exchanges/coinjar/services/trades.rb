module Cryptoexchange::Exchanges
  module Coinjar
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
         "#{Cryptoexchange::Exchanges::Coinjar::Market::API_URL}/#{market_pair.base.upcase}#{market_pair.target.upcase}/trades"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Coinjar::Market::NAME

            tr.trade_id  = trade['tid']
            tr.type      = trade['taker_side']
            tr.price     = trade['price']
            tr.amount    = trade['size']

            tr.timestamp = DateTime.rfc3339(trade['timestamp']).to_time.to_i
            tr.payload   = trade

            tr
          end
        end
      end
    end
  end
end
