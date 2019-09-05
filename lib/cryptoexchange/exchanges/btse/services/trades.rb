module Cryptoexchange::Exchanges
  module Btse
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Btse::Market::API_URL}/trades/#{market_pair.base}-#{market_pair.target}"
        end

        def adapt(output, market_pair)
          output.map do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Btse::Market::NAME
            tr.trade_id        = trade['serial_id']
            tr.type      = trade['type']
            tr.price     = trade['price']
            tr.amount    = trade['amount']
            tr.timestamp = DateTime.parse(trade['time']).to_time.to_i
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
