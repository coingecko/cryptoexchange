module Cryptoexchange::Exchanges
  module Lbank
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          market = "#{market_pair.base}_#{market_pair.target}".downcase
          "#{Cryptoexchange::Exchanges::Lbank::Market::API_URL}/trades.do?symbol=#{market}&size=100"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Lbank::Market::NAME

            tr.trade_id  = trade['tid']
            tr.type      = trade['type']
            tr.price     = trade['price']
            tr.amount    = trade['amount']
            tr.timestamp = trade['date_ms']
            tr.payload   = trade
            
            tr
          end
        end
      end
    end
  end
end
