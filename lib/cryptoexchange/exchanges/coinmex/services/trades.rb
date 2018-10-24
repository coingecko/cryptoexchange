module Cryptoexchange::Exchanges
  module Coinmex
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Coinmex::Market::API_URL}/spot/public/products/#{market_pair.base}_#{market_pair.target}/fills"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade[4]
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.type      = trade[2]
            tr.price     = trade[0]
            tr.amount    = trade[1]
            tr.timestamp = trade[3]/1000
            tr.payload   = trade
            tr.market    = Coinmex::Market::NAME
            tr
          end
        end
      end
    end
  end
end
