module Cryptoexchange::Exchanges
  module Btcsquare
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          base   = market_pair.base
          target = market_pair.target
          "#{Cryptoexchange::Exchanges::Btcsquare::Market::API_URL}/history/#{target}-#{base}"
        end

        def adapt(output, market_pair)
          puts output
          output.map do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Btcsquare::Market::NAME
            tr.type      = trade['type']
            tr.price     = trade['price']
            tr.amount    = trade['quantity']
            tr.timestamp = trade['date'].to_i
            tr.payload   = trade
          end
        end
      end
    end
  end
end
