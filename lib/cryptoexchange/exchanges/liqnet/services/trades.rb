module Cryptoexchange::Exchanges
  module Liqnet
    module Services
      class Trades < Cryptoexchange::Services::Market

        def fetch(market_pair)
          pair_id = IdFetcher.get_id(market_pair)
          output = super(ticker_url(pair_id))
          adapt(output, market_pair)
        end

        def ticker_url(pair_id)
          "#{Cryptoexchange::Exchanges::Liqnet::Market::API_URL}/marketLastTrades?id=#{pair_id}"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Liqnet::Market::NAME
            tr.price     = trade['rate']
            tr.amount    = trade['amount']
            tr.type      = trade['side'] == 0 ? 'buy' : 'sell'
            tr.timestamp = trade['timestamp']
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
