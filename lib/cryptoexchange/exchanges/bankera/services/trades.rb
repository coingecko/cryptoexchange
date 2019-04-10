module Cryptoexchange::Exchanges
  module Bankera
    module Services
      class Trades < Cryptoexchange::Services::Market

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          base   = market_pair.base.downcase
          target = market_pair.target.downcase
          "#{Cryptoexchange::Exchanges::Bankera::Market::API_URL}/trades//#{base}-#{target}"
        end

        def adapt(output, market_pair)
          output['trades'].collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = nil
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Bankera::Market::NAME
            tr.type      = trade['side']
            tr.price     = NumericHelper.to_d(trade['price'])
            tr.amount    = NumericHelper.to_d(trade['amount'])
            tr.timestamp = NumericHelper.to_d(trade['time']) / 1000
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
