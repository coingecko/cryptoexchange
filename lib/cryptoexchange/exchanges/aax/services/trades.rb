module Cryptoexchange::Exchanges
  module Aax
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          base   = market_pair.base
          target = market_pair.target
          "#{Cryptoexchange::Exchanges::Aax::Market::API_URL}/#{base}#{target}@trades?limit=2000"
        end

        def adapt(output, market_pair)
          output['trades'].collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Aax::Market::NAME
            tr.type      = trade["p"].to_f < 0 ? "sell" : "buy"
            tr.price     = trade["p"].to_f < 0 ? trade["p"].to_f.abs : trade["p"].to_f
            tr.amount    = trade['q'].to_f
            tr.timestamp = trade['t'].to_i / 1000
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
