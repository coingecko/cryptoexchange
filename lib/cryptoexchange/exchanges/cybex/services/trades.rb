module Cryptoexchange::Exchanges
  module Cybex
    module Services
      class Trades < Cryptoexchange::Services::Market
        SECONDS = 86400

        def fetch(market_pair)
          base        = market_pair.base
          target      = market_pair.target
          now         = transform_time_string(Time.now.utc)
          one_day_ago = transform_time_string(Time.now.utc - SECONDS)
          output      = fetch_using_post(ticker_url,
                                         { "jsonrpc": "2.0", "method": "get_trade_history", "params": ["#{target}", "#{base}", now, one_day_ago, 100], "id": 1 })
          adapt(output, market_pair)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Cybex::Market::API_URL}"
        end

        def adapt(output, market_pair)
          output['result'].collect do |trade|
            tr           = Cryptoexchange::Models::Trade.new
            tr.trade_id  = nil
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Cybex::Market::NAME
            tr.price     = trade['price']
            tr.amount    = trade['amount']
            tr.timestamp = Time.parse(trade['date']).to_i
            tr.payload   = trade
            tr
          end
        end

        def transform_time_string(time)
          time.strftime("%FT%R")
        end
      end
    end
  end
end
