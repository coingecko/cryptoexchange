module Cryptoexchange::Exchanges
  module Negociecoins
    module Services
      class Trades < Cryptoexchange::Services::Market

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          base   = market_pair.base.downcase
          target = market_pair.target.downcase
          "#{Cryptoexchange::Exchanges::Negociecoins::Market::API_URL}/#{base}#{target}/trades"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['tid']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Negociecoins::Market::NAME
            tr.type      = trade['type'].downcase
            tr.price     = trade['price']
            tr.amount    = trade['amount']
            tr.timestamp = trade['date']
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
