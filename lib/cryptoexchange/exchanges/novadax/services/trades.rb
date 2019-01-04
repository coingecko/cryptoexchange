module Cryptoexchange::Exchanges
  module Novadax
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Novadax::Market::API_URL}/data/trades?coin=#{market_pair.base}"
        end

        {
          "amount": 0.01909679,
          "price": 15075,
          "transType": "BUY",
          "date": 1544020892000
        }

        def adapt(output, market_pair)
          output['data'].collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.type      = trade['transType'].downcase
            tr.price     = trade['price']
            tr.amount    = trade['amount']
            tr.timestamp = trade['date'] / 1000
            tr.payload   = trade
            tr.market    = Novadax::Market::NAME
            tr
          end
        end
      end
    end
  end
end
