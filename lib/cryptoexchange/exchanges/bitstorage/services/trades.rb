module Cryptoexchange::Exchanges
  module Bitstorage
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Bitstorage::Market::API_URL}/transactions?market=#{market_pair.base}&currency=#{market_pair.target}"
        end

        def adapt(output, market_pair)
          output['transactions']['data'].collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['id']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Bitstorage::Market::NAME
            tr.type      = trade['maker_type']
            tr.price     = trade['price']
            tr.amount    = trade['amount']
            tr.timestamp = trade['timestamp']
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
