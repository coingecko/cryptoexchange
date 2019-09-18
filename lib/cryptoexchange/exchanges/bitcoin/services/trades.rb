module Cryptoexchange::Exchanges
  module Bitcoin
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Bitcoin::Market::API_URL}/trades/#{market_pair.base}#{market_pair.target}"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr           = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.trade_id  = trade['id']
            tr.price     = trade['price']
            tr.amount    = trade['quantity']
            tr.type      = trade['side']
            tr.timestamp = Time.parse(trade['timestamp']).to_i
            tr.payload   = trade
            tr.market    = Bitcoin::Market::NAME
            tr
          end
        end
      end
    end
  end
end
