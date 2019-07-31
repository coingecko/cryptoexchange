module Cryptoexchange::Exchanges
  module DoveWallet
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::DoveWallet::Market::API_URL}/getmarkethistory?market=#{market_pair.target}-#{market_pair.base}"
        end

        def adapt(output, market_pair)
          output['result'].collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = DoveWallet::Market::NAME
            tr.type      = trade['OrderType'].downcase
            tr.price     = trade['Price']
            tr.amount    = trade['Total']
            tr.timestamp = DateTime.parse(trade['TimeStamp']).to_time.to_i
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
