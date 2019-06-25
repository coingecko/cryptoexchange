module Cryptoexchange::Exchanges
  module Oceanex
    module Services
      class Trades < Cryptoexchange::Services::Market

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          base   = market_pair.base.downcase
          target = market_pair.target.downcase
          "#{Cryptoexchange::Exchanges::Oceanex::Market::API_URL}/trades?market=#{base}#{target}"
        end

        def adapt(output, market_pair)
          output['data'].collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['id']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Oceanex::Market::NAME
            tr.type      = trade['side']
            tr.price     = NumericHelper.to_d(trade['price'])
            tr.amount    = NumericHelper.to_d(trade['volume'])
            tr.timestamp = Time.parse(trade['created_at']).to_i
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
