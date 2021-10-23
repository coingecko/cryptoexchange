module Cryptoexchange::Exchanges
  module Cashpayz
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Cashpayz::Market::API_URL}/get-trades-history/#{market_pair.target}/#{market_pair.base}"
        end

        def adapt(output, market_pair)
          output["Data"].collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['tradeId']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Cashpayz::Market::NAME
            tr.price     = trade['Price']
            tr.amount    = trade['Amount']
            tr.type      = trade['Type'].downcase
            tr.timestamp = Time.parse(trade['TradeTime']).to_i
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
