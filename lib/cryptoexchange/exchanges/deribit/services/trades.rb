module Cryptoexchange::Exchanges
  module Deribit
    module Services
      class Trades < Cryptoexchange::Services::Market

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Deribit::Market::API_URL}/getlasttrades?instrument=#{market_pair.inst_id}"
        end

        def adapt(output, market_pair)
          output["result"].collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['tradeId']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Deribit::Market::NAME
            tr.type      = trade['direction'].downcase
            tr.price     = trade['price']
            tr.amount    = trade['amount']
            tr.timestamp = trade['timeStamp'].to_i / 1000
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
