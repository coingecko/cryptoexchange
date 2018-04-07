module Cryptoexchange::Exchanges
  module Gopax
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Gopax::Market::API_URL}/trading-pairs/#{market_pair.base}-#{market_pair.target}/trades"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['id']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.type      = trade['side']
            tr.price     = trade['price']
            tr.amount    = trade['amount']
            tr.timestamp = DateTime.parse(trade['time']).to_time.to_i
            tr.payload   = trade
            tr.market    = Gopax::Market::NAME
            tr
          end
        end
      end
    end
  end
end
