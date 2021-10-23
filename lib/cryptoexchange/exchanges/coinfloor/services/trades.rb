module Cryptoexchange::Exchanges
  module Coinfloor
    module Services
      class Trades < Cryptoexchange::Services::Market

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          base   = market_pair.base
          target = market_pair.target
          "#{Cryptoexchange::Exchanges::Coinfloor::Market::API_URL}/#{base}/#{target}/transactions/"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr           = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['tid']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Coinfloor::Market::NAME
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
