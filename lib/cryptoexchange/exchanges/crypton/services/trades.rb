module Cryptoexchange::Exchanges
  module Crypton
    module Services
      class Trades < Cryptoexchange::Services::Market

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output['result'], market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Crypton::Market::API_URL}/markets/#{market_pair.base}-#{market_pair.target}/trades?limit=50"
        end

        def adapt(output, market_pair)

          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['id']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Crypton::Market::NAME
            tr.type      = trade['side']
            tr.price     = trade['price'].to_f
            tr.amount    = trade['size'].to_f
            tr.timestamp = DateTime.parse(trade['time']).to_time.to_i
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
