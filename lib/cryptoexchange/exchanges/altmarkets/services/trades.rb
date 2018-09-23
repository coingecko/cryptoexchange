module Cryptoexchange::Exchanges
  module Altmarkets
    module Services
      class Trades < Cryptoexchange::Services::Market

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          base   = market_pair.base
          target = market_pair.target
          "#{Cryptoexchange::Exchanges::Altmarkets::Market::API_URL}/public/getmarkethistory?market=#{target}-#{base}"
        end

        def adapt(output, market_pair)
          output['result'].collect do |trade|
            tr           = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['Id']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Altmarkets::Market::NAME
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
