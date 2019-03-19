module Cryptoexchange::Exchanges
  module Coinzo
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Coinzo::Market::API_URL}/trades?pair=#{market_pair.base}-#{market_pair.target}"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Coinzo::Market::NAME
            tr.type      = trade['side'].downcase
            tr.price     = trade['price']
            tr.amount    = trade['amount']
            tr.timestamp = trade['created_at']
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
