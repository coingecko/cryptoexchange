module Cryptoexchange::Exchanges
  module BiboxFutures
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::BiboxFutures::Market::API_URL}/mdata?cmd=deals&pair=#{market_pair.inst_id}"
        end

        def adapt(output, market_pair)
          trades = output['result']
          trades.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.type      = trade['side'] == 2 ? "sell" : "buy"
            tr.price     = trade['price'].to_f
            tr.amount    = trade['amount'].to_f
            tr.timestamp = trade['time'].to_i / 1000
            tr.payload   = trade
            tr.market    = BiboxFutures::Market::NAME
            tr
          end
        end
      end
    end
  end
end
