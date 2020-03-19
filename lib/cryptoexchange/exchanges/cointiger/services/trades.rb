module Cryptoexchange::Exchanges
  module Cointiger
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output['data']['trade_data'], market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Cointiger::Market::API_URL}/history/trade/v2?symbol=#{market_pair.base.downcase}#{market_pair.target.downcase}&size=100"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['id']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.type      = trade['side'].downcase
            tr.price     = trade['price']
            tr.amount    = trade['vol']
            tr.timestamp = trade['ts']
            tr.payload   = trade
            tr.market    = Cointiger::Market::NAME
            tr
          end
        end
      end
    end
  end
end
