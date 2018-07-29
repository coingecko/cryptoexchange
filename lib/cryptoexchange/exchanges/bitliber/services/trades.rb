module Cryptoexchange::Exchanges
  module Bitliber
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Bitliber::Market::API_URL}/public/history/#{market_pair.base}-#{market_pair.target}"
        end

        def adapt(output, market_pair)
          output['result'].map do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Bitliber::Market::NAME
            tr.type      = trade['type']
            tr.price     = trade['price']
            tr.amount    = trade['quantity']
            tr.timestamp = trade['date'].to_i / 1000
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
