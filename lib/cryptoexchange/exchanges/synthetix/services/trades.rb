module Cryptoexchange::Exchanges
  module Synthetix
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(trades_url(market_pair))
          adapt(output, market_pair)
        end

        def trades_url(market_pair)
          "https://api.synthetix.io/api/exchange/transactions/susd-sbtc"
          "#{Cryptoexchange::Exchanges::Synthetix::Market::API_URL}/transactions/#{market_pair.base}-#{market_pair.target}"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.type      = trade["type"]
            tr.price     = trade["rate"]
            tr.amount    = trade["amount"]
            tr.timestamp = Time.parse(trade['ts']).to_i
            tr.payload   = trade
            tr.market    = Synthetix::Market::NAME
            tr
          end
        end
      end
    end
  end
end
