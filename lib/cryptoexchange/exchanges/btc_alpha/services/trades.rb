module Cryptoexchange::Exchanges
  module BtcAlpha
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          base   = market_pair.base
          target = market_pair.target
          "#{Cryptoexchange::Exchanges::BtcAlpha::Market::API_URL}/orderbook/#{base}_#{target}?status=2"
        end

        def adapt(output, market_pair)
          trades = []
          output['sell'].map do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['id']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = BtcAlpha::Market::NAME
            tr.type      = 'sell'
            tr.price     = trade['price']
            tr.amount    = trade['amount']
            tr.timestamp = trade['timestamp'].to_i
            tr.payload   = trade
            trades << tr
          end

          output['buy'].map do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['id']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = BtcAlpha::Market::NAME
            tr.type      = 'sell'
            tr.price     = trade['price']
            tr.amount    = trade['amount']
            tr.timestamp = trade['timestamp'].to_i
            tr.payload   = trade
            trades << tr
          end

          trades
        end
      end
    end
  end
end
