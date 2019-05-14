module Cryptoexchange::Exchanges
  module Bitasset
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Bitasset::Market::API_URL}/trades?symbol=#{market_pair.base}_#{market_pair.target}&size=50"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Bitasset::Market::NAME
            tr.type      = trade[3] > 0 ? "buy" : "sell"
            tr.price     = trade[1]
            tr.amount    = trade[2]
            tr.timestamp = trade[0]/1_000_000
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
