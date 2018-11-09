module Cryptoexchange::Exchanges
  module Sapotaexchange
    module Services
      class Trades < Cryptoexchange::Services::Market

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Sapotaexchange::Market::API_URL}/recent_trades/#{market_pair.base}/#{market_pair.target}"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Sapotaexchange::Market::NAME
            tr.type      = trade['bid'] ? "buy" : "sell"
            tr.price     = trade['price'].to_f
            tr.amount    = trade['amount'].to_f
            tr.timestamp = trade['created']/1000
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
