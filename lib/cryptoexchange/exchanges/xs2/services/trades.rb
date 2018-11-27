module Cryptoexchange::Exchanges
  module Xs2
    module Services
      class Trades < Cryptoexchange::Services::Market

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Xs2::Market::API_URL}/cryptocompare/v1/trades?pair=#{market_pair.base}/#{market_pair.target}"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['id']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Xs2::Market::NAME
            tr.type      = trade['isBuyerMaker'].downcase
            tr.price     = trade['price']
            tr.amount    = trade['amount']
            tr.timestamp = trade['timestamp'].to_i/1000
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
