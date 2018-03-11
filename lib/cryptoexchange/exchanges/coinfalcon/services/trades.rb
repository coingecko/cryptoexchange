module Cryptoexchange::Exchanges
  module Coinfalcon
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Coinfalcon::Market::API_URL}markets/#{market_pair.base.downcase}-#{market_pair.target.downcase}/trades"
          /
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['tid']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.type      = trade['type'] == '0' ? 'buy' : 'sell'
            tr.price     = trade['price']
            tr.amount    = trade['amount']
            tr.timestamp = trade['date'].to_i
            tr.payload   = trade
            tr.market    = Coinfalcon::Market::NAME
            tr
          end
        end
      end
    end
  end
end
