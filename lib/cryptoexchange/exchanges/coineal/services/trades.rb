module Cryptoexchange::Exchanges
  module Coineal
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Coineal::Market::API_URL}/get_trades?symbol=#{market_pair.base.downcase}#{market_pair.target.downcase}"
        end

        def adapt(output, market_pair)
          output['data'].collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['id']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Coineal::Market::NAME
            tr.price     = trade['price']
            tr.amount    = trade['amount']
            tr.type      = trade['type']
            tr.timestamp = trade['trade_time']/1000
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
