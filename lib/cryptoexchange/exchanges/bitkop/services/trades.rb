module Cryptoexchange::Exchanges
  module Bitkop
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output['data'], market_pair)
        end
        
        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Bitkop::Market::API_URL}/order?symbol=#{market_pair.base.downcase}_#{market_pair.target.downcase}"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['id']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Bitkop::Market::NAME
            tr.type      = trade['s']
            tr.price     = trade['p']
            tr.amount    = trade['n']
            tr.timestamp = trade['T']
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
