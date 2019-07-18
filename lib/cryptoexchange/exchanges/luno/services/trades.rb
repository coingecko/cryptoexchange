module Cryptoexchange::Exchanges
  module Luno
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Luno::Market::API_URL}/trades?pair=#{market_pair.base}#{market_pair.target}"
        end

        def adapt(output, market_pair)
          output['trades'].collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Luno::Market::NAME

            tr.trade_id  = trade['sequence']
            tr.type      = trade['is_buy'] ? "buy" : "sell"
            tr.price     = trade['price'].to_f
            tr.amount    = trade['volume'].to_f
            tr.timestamp = trade['timestamp']/1000
            tr.payload   = trade

            tr
          end
        end
      end
    end
  end
end
