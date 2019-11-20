module Cryptoexchange::Exchanges
  module Paribu
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Paribu::Market::API_URL}/api/v1/trades/#{market_pair.base.downcase}_#{market_pair.target.downcase}"
        end

        def adapt(output, market_pair)
          output['trades'].collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Paribu::Market::NAME
            tr.type      = trade["tr"]
            tr.price     = trade["mp"]
            tr.amount    = trade["ma"]
            tr.timestamp = Time.parse(trade["dt"]).to_i
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
