module Cryptoexchange::Exchanges
  module Paymium
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Paymium::Market::API_URL}/data/eur/trades"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['uuid']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.type      = trade['side']
            tr.price     = trade['price']
            tr.amount    = trade['traded_btc']
            tr.timestamp = trade['created_at_int'].to_i
            tr.payload   = trade
            tr.market    = Paymium::Market::NAME
            tr
          end
        end
      end
    end
  end
end
