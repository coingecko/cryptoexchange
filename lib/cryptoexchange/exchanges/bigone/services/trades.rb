module Cryptoexchange::Exchanges
  module Bigone
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Bigone::Market::API_URL}/asset_pairs/#{market_pair.base.upcase}-#{market_pair.target.upcase}/trades"
        end

        def adapt(output, market_pair)
          output['data'].collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['id']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Bigone::Market::NAME
            tr.type      = trade['taker_side'] == "ASK" ? "sell" : "buy"
            tr.price     = trade['price']
            tr.amount    = trade['amount']
            tr.timestamp = Time.parse(trade['inserted_at']).to_i
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
