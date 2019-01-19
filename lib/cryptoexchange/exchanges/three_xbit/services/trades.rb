module Cryptoexchange::Exchanges
  module ThreeXbit
    module Services
      class Trades < Cryptoexchange::Services::Market

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output['history'], market_pair)
        end

        def ticker_url(market_pair)
          base = market_pair.base.downcase
          target = market_pair.target.downcase
          "#{Cryptoexchange::Exchanges::ThreeXbit::Market::API_URL}/v1/history/#{target}/#{base}/"
        end

        def adapt(output, market_pair)
          output['results'].collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['transaction_id']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = ThreeXbit::Market::NAME
            tr.type      = trade['order_type'].downcase
            tr.price     = NumericHelper.to_d(trade['unit_price'])
            tr.amount    = NumericHelper.to_d(trade['quantity'])
            tr.timestamp = trade['timestamp'].to_i
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
