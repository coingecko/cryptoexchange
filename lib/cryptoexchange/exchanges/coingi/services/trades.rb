module Cryptoexchange::Exchanges
  module Coingi
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          base   = market_pair.base.downcase
          target = market_pair.target.downcase
          "#{Cryptoexchange::Exchanges::Coingi::Market::API_URL}/current/transactions/#{base}-#{target}/64"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr           = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.trade_id  = trade['id']
            tr.type      = trade['type'] == 1 ? 'sell' : 'buy'
            tr.price     = trade['price']
            tr.amount    = trade['amount']
            tr.timestamp = trade['timestamp'] / 1000
            tr.payload   = trade
            tr.market    = Coingi::Market::NAME
            tr
          end
        end
      end
    end
  end
end
