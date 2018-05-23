module Cryptoexchange::Exchanges
  module BtcTradeUa
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          base   = market_pair.base.downcase
          target = market_pair.target.downcase
          "#{Cryptoexchange::Exchanges::BtcTradeUa::Market::API_URL}/deals/#{base}_#{target}"
        end
        
        def adapt(output, market_pair)
          output.map do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = BtcTradeUa::Market::NAME
            tr.trade_id  = trade['id']
            tr.type      = trade['type']
            tr.price     = trade['price']
            tr.amount    = trade['amnt_trade']
            tr.timestamp = trade['unixtime']
            tr.payload   = trade
          end
        end
      end
    end
  end
end
