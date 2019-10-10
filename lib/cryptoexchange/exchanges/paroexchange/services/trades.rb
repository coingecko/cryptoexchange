module Cryptoexchange::Exchanges
  module Paroexchange
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Paroexchange::Market::API_URL}/markets/#{market_pair.base}-#{market_pair.target}/trades"
        end

        def adapt(output, market_pair)
          output['data']['edges'].collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = HashHelper.dig(trade, 'node', 'id')
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Paroexchange::Market::NAME
            tr.type      = HashHelper.dig(trade, 'node', 'taker_side') == "ASK" ? "sell" : "buy"
            tr.price     = HashHelper.dig(trade, 'node', 'price')
            tr.amount    = HashHelper.dig(trade, 'node', 'amount')
            tr.timestamp = Time.parse(HashHelper.dig(trade, 'node', 'inserted_at')).to_i
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
