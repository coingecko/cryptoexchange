module Cryptoexchange::Exchanges
  module Aex
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          base = market_pair.base.downcase
          target = market_pair.target.downcase
          "#{Cryptoexchange::Exchanges::Aex::Market::API_URL}/trades.php?c=#{base}&mk_type=#{target}"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['tid']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.price     = trade['price']
            tr.amount    = trade['amount']
            tr.type      = trade['type']
            tr.timestamp = trade['date']
            tr.payload   = trade
            tr.market    = Aex::Market::NAME
            tr
          end
        end
      end
    end
  end
end
