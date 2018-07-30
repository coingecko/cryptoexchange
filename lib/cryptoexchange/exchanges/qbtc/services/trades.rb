module Cryptoexchange::Exchanges
  module Qbtc
    module Services
      class Trades < Cryptoexchange::Services::Market
        
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Qbtc::Market::API_URL}/recentDealList.do?tradeMarket=#{market_pair.target}&symbol=#{market_pair.base}"
        end

        def adapt(output, market_pair)
          output['result'].collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.type      = trade['entrustType'] == '1' ? 'buy' : 'sell'
            tr.price     = trade['price']
            tr.amount    = trade['amount']
            tr.timestamp = trade['createTime'].to_i
            tr.payload   = trade
            tr.market    = Qbtc::Market::NAME
            tr
          end
        end
      end
    end
  end
end
