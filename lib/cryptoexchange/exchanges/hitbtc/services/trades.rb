module Cryptoexchange::Exchanges
  module Hitbtc
    module Services
      class Trades < Cryptoexchange::Services::Market

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Hitbtc::Market::API_URL}/public/trades/#{market_pair.base}#{market_pair.target}"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['id']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Hitbtc::Market::NAME
            tr.type      = trade['side']
            tr.price     = NumericHelper.to_d(trade['price'])
            tr.amount    = NumericHelper.to_d(trade['quantity'])
            tr.timestamp = DateTime.parse(trade['timestamp']).to_time.to_i
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
