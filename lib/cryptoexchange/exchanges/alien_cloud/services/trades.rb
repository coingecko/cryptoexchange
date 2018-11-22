module Cryptoexchange::Exchanges
  module AlienCloud
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::AlienCloud::Market::API_URL}/trade/pairs/#{market_pair.base.downcase}_#{market_pair.target.downcase}/history"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = AlienCloud::Market::NAME
            tr.type      = trade['directionType']
            tr.price     = trade['price']
            tr.amount    = trade['amount']
            tr.timestamp = trade['tradeTime']
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
