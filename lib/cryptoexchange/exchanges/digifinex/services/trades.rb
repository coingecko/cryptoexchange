module Cryptoexchange::Exchanges
  module Digifinex
    module Services
      class Trades < Cryptoexchange::Services::Market

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Digifinex::Market::API_URL_V3}/trades/?apikey=15cad9a55217c4&market=#{market_pair.base}_#{market_pair.target}"
        end

        def adapt(output, market_pair)
          output["data"].collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.type      = trade['type'].downcase
            tr.price     = trade['price']
            tr.amount    = trade['amount']
            tr.timestamp = trade['date'].to_i
            tr.payload   = trade
            tr.market    = Digifinex::Market::NAME
            tr
          end
        end
      end
    end
  end
end
