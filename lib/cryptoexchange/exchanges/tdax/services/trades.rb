module Cryptoexchange::Exchanges
  module Tdax
    module Services
      class Trades < Cryptoexchange::Services::Market

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          name = "#{market_pair.base}_#{market_pair.target}"

          "#{Cryptoexchange::Exchanges::Tdax::Market::API_URL}/public/getmarkethistory?market=#{name}"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['ID']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Tdax::Market::NAME
            tr.price     = trade['Price']
            tr.amount    = trade['Qty']
            tr.timestamp = Time.parse(trade['CreatedAt']).to_i
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
