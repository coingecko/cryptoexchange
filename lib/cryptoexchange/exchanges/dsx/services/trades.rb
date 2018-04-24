module Cryptoexchange::Exchanges
  module Dsx
    module Services
      class Trades < Cryptoexchange::Services::Market

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          base = market_pair.base.downcase
          target = market_pair.target.downcase
          "#{Cryptoexchange::Exchanges::Dsx::Market::API_URL}/trades/#{base}#{target}/"
        end

        def adapt(output, market_pair)
          data = output["#{market_pair.base.downcase}#{market_pair.target.downcase}"]
          data.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['tid']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Dsx::Market::NAME
            tr.type      = trade['type'] == "bid" ? "buy" : "sell"
            tr.price     = trade['price']
            tr.amount    = trade['amount']
            tr.timestamp = trade['timestamp']
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
