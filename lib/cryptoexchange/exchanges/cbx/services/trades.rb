module Cryptoexchange::Exchanges
  module Cbx
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Cbx::Market::API_URL}/asset_pairs/#{market_pair.base}-#{market_pair.target}/trades"
        end

        def adapt(output, market_pair)
          output["data"].collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['id']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Cbx::Market::NAME

            tr.price     = trade['price']
            tr.amount    = trade['amount']
            tr.type      = trade['taker_side']
            tr.timestamp = Time.parse(trade['inserted_at']).to_i
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
