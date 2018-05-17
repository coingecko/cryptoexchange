module Cryptoexchange::Exchanges
  module Bithash
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          base   = market_pair.base.downcase
          target = market_pair.target.downcase
          "#{Cryptoexchange::Exchanges::Bithash::Market::API_URL}/trades/#{base}_#{target}"
        end

        def adapt(output, market_pair)
          base   = market_pair.base.downcase
          target = market_pair.target.downcase
          output["#{base}_#{target}"].collect do |trade|
            tr           = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.trade_id  = trade['tid']
            tr.price     = trade['price']
            tr.amount    = trade['amount']
            tr.type      = trade['type'] == 'bid' ? 'buy' : 'sell'
            tr.timestamp = trade['timestamp']
            tr.payload   = trade
            tr.market    = Bithash::Market::NAME
            tr
          end
        end
      end
    end
  end
end
