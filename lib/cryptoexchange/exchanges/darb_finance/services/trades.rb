module Cryptoexchange::Exchanges
  module DarbFinance
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::DarbFinance::Market::API_URL}/trades?symbol=#{market_pair.base.upcase}_#{market_pair.target.upcase}"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = DarbFinance::Market::NAME
            tr.price     = trade['price']
            tr.amount    = trade['qty']
            tr.timestamp = trade['time'] / 1000
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
