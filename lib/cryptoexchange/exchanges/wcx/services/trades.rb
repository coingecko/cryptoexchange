module Cryptoexchange::Exchanges
  module Wcx
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          base = market_pair.base
          target = market_pair.target
          "#{Cryptoexchange::Exchanges::Wcx::Market::API_URL}/trades/#{base}-#{target}"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['id']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.type      = trade['side']
            tr.price     = trade['price']
            tr.amount    = trade['size']
            tr.timestamp = Time.parse(trade['timestamp']).to_i
            tr.payload   = trade
            tr.market    = Wcx::Market::NAME
            tr
          end
        end
      end
    end
  end
end
