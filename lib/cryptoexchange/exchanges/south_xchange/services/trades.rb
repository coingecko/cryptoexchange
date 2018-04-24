module Cryptoexchange::Exchanges
  module SouthXchange
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::SouthXchange::Market::API_URL}/trades/#{market_pair.base}/#{market_pair.target}"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.type      = trade['Type']
            tr.price     = trade['Price']
            tr.amount    = trade['Amount']
            tr.timestamp = trade['At']
            tr.payload   = trade
            tr.market    = SouthXchange::Market::NAME
            tr
          end
        end
      end
    end
  end
end
