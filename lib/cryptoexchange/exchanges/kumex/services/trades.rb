module Cryptoexchange::Exchanges
  module Kumex
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Kumex::Market::API_URL}/trade/history?symbol=#{market_pair.inst_id}"
        end


        def adapt(output, market_pair)
          output = output['data']
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['tradeId']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.type      = trade['side'].downcase
            tr.price     = trade['price']
            tr.amount    = trade['size']
            tr.timestamp = trade['ts'] / 1000000000
            tr.payload   = trade
            tr.market    = Kumex::Market::NAME
            tr
          end
        end
      end
    end
  end
end
