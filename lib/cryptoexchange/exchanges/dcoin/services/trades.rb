module Cryptoexchange::Exchanges
  module Dcoin
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Dcoin::Market::API_URL}/open/api/get_trades?symbol=#{market_pair.base.downcase}#{market_pair.target.downcase}&size=100"
        end


        def adapt(output, market_pair)
          output = output['data']
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['id']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.type      = trade['direction'].downcase
            tr.price     = trade['price']
            tr.amount    = trade['volume']
            tr.timestamp = trade['ts'] / 1000
            tr.payload   = trade
            tr.market    = Dcoin::Market::NAME
            tr
          end
        end
      end
    end
  end
end
