module Cryptoexchange::Exchanges
  module Ice3x
    module Services
      class Trades < Cryptoexchange::Services::Market

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output['response']['entities'], market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Ice3x::Market::API_URL}/trade/list?pair_id=#{market_pair.inst_id}"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['trade_id']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Ice3x::Market::NAME
            tr.type      = trade['type']
            tr.price     = trade['price']
            tr.amount    = trade['volume']
            tr.timestamp = trade['created']
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
