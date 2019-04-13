module Cryptoexchange::Exchanges
  module Dakuce
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Dakuce::Market::API_URL}/getmarkethistory?market=#{market_pair.base}-#{market_pair.target}"
        end

        def adapt(output, market_pair)
          output['result'].collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Dakuce::Market::NAME
            tr.type      = trade['type'] == "Bid" ? 'buy' : 'sell'
            tr.price     = trade['per_price']
            tr.amount    = trade['volume']
            tr.timestamp = trade['created_at']
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
