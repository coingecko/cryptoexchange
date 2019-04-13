module Cryptoexchange::Exchanges
  module Hpx
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Hpx::Market::API_URL}/trades?currency=#{market_pair.base.downcase}_#{market_pair.target.upcase}"
        end

        def adapt(output, market_pair)
          output['data'].collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['id']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Hpx::Market::NAME
            tr.type      = trade['en_type'] == 0 ? 'buy' : 'sell'
            tr.price     = trade['price']
            tr.amount    = trade['amount']
            tr.timestamp = nil
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
