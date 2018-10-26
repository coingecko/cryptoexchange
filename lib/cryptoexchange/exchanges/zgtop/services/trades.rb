module Cryptoexchange::Exchanges
  module Zgtop
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Zgtop::Market::API_URL}/orders?symbol=#{market_pair.inst_id}&size=100"
        end

        def adapt(output, market_pair)
          output['data'].collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.type      = trade['type']
            tr.price     = trade['price'].to_f
            tr.amount    = trade['count'].to_f
            tr.timestamp = trade['date']
            tr.payload   = trade
            tr.market    = Zgtop::Market::NAME
            tr
          end
        end
      end
    end
  end
end
