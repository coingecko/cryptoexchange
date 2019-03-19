module Cryptoexchange::Exchanges
  module Zg
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          base   = market_pair.base
          target = market_pair.target
          "#{Cryptoexchange::Exchanges::Zg::Market::API_URL}/trades?symbol=#{base}_#{target}&size=20"
        end

        def adapt(output, market_pair)
          output.map do |trade|
            tr           = Cryptoexchange::Models::Trade.new
            tr.trade_id  = nil
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Zg::Market::NAME
            tr.type      = trade['side']
            tr.price     = NumericHelper.to_d(trade['price'])
            tr.amount    = NumericHelper.to_d(trade['amount'])
            tr.timestamp = NumericHelper.to_d(trade['timestamp']) / 1000
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
