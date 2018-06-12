module Cryptoexchange::Exchanges
  module Coin2001
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          base   = market_pair.base
          target = market_pair.target
          "#{Cryptoexchange::Exchanges::Coin2001::Market::API_URL}/v1/public/getMarketHistory?market=#{target}_#{base}"
        end

        def adapt(output, market_pair)
          output['result'].collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['Id']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Coin2001::Market::NAME
            tr.type      = trade['OrderType'].downcase
            tr.price     = trade['Price']
            tr.amount    = trade['Quantity']
            tr.timestamp = Time.parse(trade['TimeStamp']).to_i
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
