module Cryptoexchange::Exchanges
  module CPatex
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          market="#{market_pair.base.downcase}#{market_pair.target.downcase}"
          "#{Cryptoexchange::Exchanges::CPatex::Market::API_URL}/trades.json?market=#{market}"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['id']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = CPatex::Market::NAME
            tr.price     = trade['price']
            tr.amount    = trade['volume']
            tr.timestamp = Time.parse(trade['created_at']).to_i
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
