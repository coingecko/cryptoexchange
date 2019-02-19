module Cryptoexchange::Exchanges
  module Therocktrading
    module Services
      class Trades < Cryptoexchange::Services::Market

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Therocktrading::Market::API_URL}/funds/#{market_pair.base}#{market_pair.target}/trades"
        end

        def adapt(output, market_pair)
          output["trades"].collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['id']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Therocktrading::Market::NAME
            tr.type      = trade['side']
            tr.price     = trade['price']
            tr.amount    = trade['amount']
            tr.timestamp = DateTime.parse(trade['date']).to_time.to_i
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
