module Cryptoexchange::Exchanges
  module Bitonbay
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Bitonbay::Market::API_URL}/history?market=#{market_pair.target}&symbol=#{market_pair.base}"
        end

        def adapt(output, market_pair)
          output["data"].collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['seq']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Bitonbay::Market::NAME
            tr.type      = trade['order_type'] == 'ask' ? 'sell' : 'buy'
            tr.price     = trade['price']
            tr.amount    = trade['unit_traded']
            tr.timestamp = Time.parse(trade['transaction_date']).to_i
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
