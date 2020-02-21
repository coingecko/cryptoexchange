module Cryptoexchange::Exchanges
  module Artisturba
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = HTTP.get(ticker_url(market_pair)).parse(:json)
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Artisturba::Market::API_URL}/trade_history/#{market_pair.base}_#{market_pair.target}"
        end

        def adapt(output, market_pair)
          trades = output['trade_history']
          trades.collect do |trade|
            tr           = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.trade_id  = nil
            tr.type      = trade['type'].downcase
            tr.price     = trade['rate']
            tr.amount    = trade['amount']
            tr.timestamp = DateTime.parse(trade['date']).to_time.to_i
            tr.payload   = trade
            tr.market    = Artisturba::Market::NAME
            tr
          end
        end
      end
    end
  end
end
