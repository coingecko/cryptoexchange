module Cryptoexchange::Exchanges
  module Kuna
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Kuna::Market::API_URL}/trades?market=#{market_pair.base.downcase}#{market_pair.target.downcase}"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['id']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.type      = trade['side'] == 'null' ? nil : trade['side']
            tr.price     = trade['price']
            tr.amount    = trade['volume']
            tr.timestamp = Time.parse(trade['created_at']).to_i
            tr.payload   = trade
            tr.market    = Kuna::Market::NAME
            tr
          end
        end
      end
    end
  end
end
