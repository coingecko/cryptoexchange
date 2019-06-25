module Cryptoexchange::Exchanges
  module Kraken
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(trades_url(market_pair))
          adapt(output, market_pair)
        end

        def trades_url(market_pair)
          base = market_pair.base
          target = market_pair.target
          "#{Cryptoexchange::Exchanges::Kraken::Market::API_URL}/Trades?pair=#{base}#{target}"
        end

        def adapt(output, market_pair)
          output["result"].flatten[1].collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = nil
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.type      = trade[3] == "s" ? "sell" : "buy"
            tr.price     = trade[0].to_f
            tr.amount    = trade[1].to_f
            tr.timestamp = trade[2].to_i
            tr.payload   = trade
            tr.market    = Kraken::Market::NAME
            tr
          end
        end
      end
    end
  end
end
