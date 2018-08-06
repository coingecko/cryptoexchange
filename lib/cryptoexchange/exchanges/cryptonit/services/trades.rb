module Cryptoexchange::Exchanges
  module Cryptonit
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          base = market_pair.base.downcase
          target = market_pair.target.downcase
          "#{Cryptoexchange::Exchanges::Cryptonit::Market::API_URL}/transactions/#{base}#{target}"
        end

        {
          "date": 1532909226,
          "tid": 497475,
          "price": 400,
          "type": 1,
          "amount": 0.30578023
        }

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['tid']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Cryptonit::Market::NAME
            tr.type      = trade['type'] == 0 ? "buy" : "sell"
            tr.price     = trade['price']
            tr.amount    = trade['amount']
            tr.timestamp = trade['date'].to_i
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
