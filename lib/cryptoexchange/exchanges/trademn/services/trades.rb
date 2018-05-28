module Cryptoexchange::Exchanges
  module Trademn
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Trademn::Market::API_URL}/recent_transactions/#{market_pair.base}#{market_pair.target}"
        end

        def adapt(output, market_pair)
          output["data"].collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Trademn::Market::NAME
            tr.type      = trade["type"] == "ask" ? "sell" : "buy"
            tr.price     = trade["price"]
            tr.amount    = trade["quantity"]
            tr.timestamp = trade["date"].to_i
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
