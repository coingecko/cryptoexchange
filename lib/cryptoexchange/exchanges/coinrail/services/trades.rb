module Cryptoexchange::Exchanges
  module Coinrail
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Coinrail::Market::API_URL}/public/last/transaction?currency=#{market_pair.base}-#{market_pair.target}"
        end

        def adapt(output, market_pair)
          output['transaction_list'].collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Coinrail::Market::NAME
            tr.price     = trade['price']
            tr.amount    = trade['qty']
            tr.timestamp = trade['time'].to_i
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
