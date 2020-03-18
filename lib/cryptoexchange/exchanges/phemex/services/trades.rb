module Cryptoexchange::Exchanges
  module Phemex
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Phemex::Market::API_URL}/trade?symbol=#{market_pair.inst_id}"
        end

        def adapt(output, market_pair)
          output["result"]["trades"].collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target

            tr.trade_id  = trade[1]
            tr.type      = trade[2].downcase
            tr.price     = NumericHelper.divide(NumericHelper.to_d(trade[3]), 10000)
            tr.amount    = trade[4]
            tr.timestamp = trade[0] / 1000000000
            tr.payload   = trade
            tr.market    = Phemex::Market::NAME
            tr
          end
        end
      end
    end
  end
end
