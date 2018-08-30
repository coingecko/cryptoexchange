module Cryptoexchange::Exchanges
  module Dextop
    module Services
      class Trades < Cryptoexchange::Services::Market

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Dextop::Market::API_URL}/tradehistory/#{market_pair.target}_#{market_pair.base}/3"
        end

        def adapt(output, market_pair)
          output['records'].collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.type      = trade['action'].downcase
            tr.price     = trade['price']
            tr.amount    = trade['amount']
            tr.timestamp = trade['timeMs'].to_i/1000
            tr.payload   = trade
            tr.market    = Dextop::Market::NAME
            tr
          end
        end
      end
    end
  end
end
