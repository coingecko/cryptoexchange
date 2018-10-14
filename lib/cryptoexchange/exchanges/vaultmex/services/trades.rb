module Cryptoexchange::Exchanges
  module Vaultmex
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          base   = market_pair.base
          target = market_pair.target
          "#{Cryptoexchange::Exchanges::Vaultmex::Market::API_URL}/market/trades/#{base}/#{target}"
        end

        def adapt(output, market_pair)
          output['trades'].collect do |trade|
            tr           = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.type      = trade['type'].zero? ? 'buy' : 'sell'
            tr.price     = trade['price']
            tr.amount    = trade['amount']
            tr.timestamp = Time.parse(trade['time']).to_i
            tr.payload   = trade
            tr.market    = Vaultmex::Market::NAME
            tr
          end
        end
      end
    end
  end
end
