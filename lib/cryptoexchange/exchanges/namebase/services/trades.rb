module Cryptoexchange::Exchanges
  module Namebase
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(trades_url(market_pair))
          adapt(output, market_pair)
        end

        def trades_url(market_pair)
          base = market_pair.base
          target = market_pair.target
          "#{Cryptoexchange::Exchanges::Namebase::Market::API_URL}/trade?symbol=#{base}#{target}&limit=1000&timestamp=#{Time.now.to_i * 1000}"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['tradeId']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.type      = trade['isBuyerMaker'] ? "sell" : "buy"
            tr.price     = trade['price']
            tr.amount    = trade['quantity']
            tr.timestamp = (trade['createdAt']/1000).to_i
            tr.payload   = trade
            tr.market    = Namebase::Market::NAME
            tr
          end
        end
      end
    end
  end
end
