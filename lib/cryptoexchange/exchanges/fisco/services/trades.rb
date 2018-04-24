module Cryptoexchange::Exchanges
  module Fisco
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          base = market_pair.base.downcase
          target = market_pair.target.downcase
          "#{Cryptoexchange::Exchanges::Fisco::Market::API_URL}/trades/#{base}_#{target}"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Fisco::Market::NAME
            tr.trade_id  = trade['tid']
            tr.type      = trade['trade_type'] == 'bid' ? 'buy' : 'sell'
            tr.price     = trade['price']
            tr.amount    = trade['amount']
            tr.timestamp = trade['date']
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
