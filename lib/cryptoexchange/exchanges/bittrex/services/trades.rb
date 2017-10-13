module Cryptoexchange::Exchanges
  module Bittrex
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Bittrex::Market::API_URL}/public/getmarkethistory?market=#{market_pair.base}-#{market_pair.target}"
        end

        def adapt(output, market_pair)
          output.dig('result').collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade.dig('Id')
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.type      = trade.dig('OrderType')
            tr.price     = trade.dig('Price')
            tr.amount    = trade.dig('Total')
            tr.timestamp = DateTime.parse(trade.dig('TimeStamp')).to_time.to_i
            tr.payload   = trade
            tr.market    = Bittrex::Market::NAME
            tr
          end
        end
      end
    end
  end
end
