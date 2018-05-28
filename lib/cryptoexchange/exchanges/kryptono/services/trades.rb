module Cryptoexchange::Exchanges
  module Kryptono
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          base   = market_pair.base
          target = market_pair.target
          "#{Cryptoexchange::Exchanges::Kryptono::Market::API_URL}/ht?symbol=#{base}_#{target}"
        end

        def adapt(output, market_pair)
          output['history'].collect do |trade|
            tr           = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.trade_id  = trade['id']
            tr.type      = trade['isBuyerMaker'] ? 'buy' : 'sell'
            tr.price     = trade['price']
            tr.amount    = trade['qty']
            tr.timestamp = trade['time'] / 1000
            tr.payload   = trade
            tr.market    = Kryptono::Market::NAME
            tr
          end
        end
      end
    end
  end
end
