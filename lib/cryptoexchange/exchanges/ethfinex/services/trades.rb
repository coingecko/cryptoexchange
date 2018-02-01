module Cryptoexchange::Exchanges
  module Ethfinex
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Ethfinex::Market::API_URL}/v2/trades/t#{market_pair.base}#{market_pair.target}/hist"
        end

        def adapt(output, market_pair)

          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade[0]
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Ethfinex::Market::NAME
            tr.type      = (trade[-2].to_f > 0 ? "buy" : "sell")
            tr.price     = trade[-1]
            tr.amount    = trade[-2].abs
            tr.timestamp = Time.now.to_i
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
