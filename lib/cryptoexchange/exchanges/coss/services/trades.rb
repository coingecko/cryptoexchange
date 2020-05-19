module Cryptoexchange::Exchanges
  module Coss
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          base = market_pair.base.upcase
          target = market_pair.target.upcase
          "#{Cryptoexchange::Exchanges::Coss::Market::API_URL}/trades/#{base}_#{target}"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['tradeID']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.price     = trade['price']
            tr.amount    = trade['base_volume']
            tr.type      = trade['type'].downcase
            tr.timestamp = trade['trade_timestamp']
            tr.payload   = trade
            tr.market    = Coss::Market::NAME
            tr
          end
        end
      end
    end
  end
end
