module Cryptoexchange::Exchanges
  module Bitoffer
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Bitoffer::Market::API_URL}/quot/tick?instrumentId=#{market_pair.inst_id}"        
        end

        def adapt(output, market_pair)
          output["data"]["ticks"].collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Bitoffer::Market::NAME
            tr.price     = trade[1]
            tr.amount    = trade[2]
            tr.type      = trade[3] == 1 ? "buy" : "sell"
            tr.timestamp = trade[0].to_i / 1000000

            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
