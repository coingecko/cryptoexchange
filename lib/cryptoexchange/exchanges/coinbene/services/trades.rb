module Cryptoexchange::Exchanges
  module Coinbene
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Coinbene::Market::API_URL}/market/trades?symbol=#{market_pair.base}#{market_pair.target}&size=2000"
        end

        def adapt(output, market_pair)
          output['trades'].collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['tradeId']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.type      = trade['take']
            tr.price     = trade['price'].to_f
            tr.amount    = trade['quantity'].to_f
            tr.timestamp = trade['time'] / 1000
            tr.payload   = trade
            tr.market    = Coinbene::Market::NAME
            tr
          end
        end
      end
    end
  end
end
