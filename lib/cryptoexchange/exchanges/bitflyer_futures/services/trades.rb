module Cryptoexchange::Exchanges
  module BitflyerFutures
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(trades_url(market_pair))
          adapt(output, market_pair)
        end

        def trades_url(market_pair)
          "#{Cryptoexchange::Exchanges::BitflyerFutures::Market::API_URL}/executions?product_code=#{market_pair.inst_id}"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['id']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.type      = trade['side'].downcase
            tr.price     = trade['price']
            tr.amount    = trade['size']
            Time.parse(trade['exec_date']).to_i
            tr.timestamp = Time.parse(trade['exec_date']).to_i
            tr.payload   = trade
            tr.market    = BitflyerFutures::Market::NAME
            tr
          end
        end
      end
    end
  end
end
