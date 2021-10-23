module Cryptoexchange::Exchanges
  module Bitmart
    module Services
      class Trades < Cryptoexchange::Services::Market

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Bitmart::Market::API_URL}/symbols/#{market_pair.base}_#{market_pair.target}/trades"
        end

        def adapt(output, market_pair)
          output.map do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Bitmart::Market::NAME

            tr.price     = trade['price']
            tr.amount    = trade['amount']
            tr.type      = trade['type']
            tr.timestamp = trade['order_time'] / 1000
            tr.payload   = trade

            tr
          end
        end
      end
    end
  end
end
