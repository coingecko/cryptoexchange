module Cryptoexchange::Exchanges
  module Bitonbay
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Bitonbay::Market::API_URL}/api-public-filledbook0x0#{market_pair.base.downcase}#{market_pair.target.downcase}"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['idx']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Bitonbay::Market::NAME
            tr.type      = trade['order_type'] == 'b' ? 'buy' : 'sell'
            tr.price     = trade['trade_price']
            tr.amount    = trade['trade_amount']
            tr.timestamp = DateTime.parse(trade['trade_date']).to_time.to_i
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
