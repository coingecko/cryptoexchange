module Cryptoexchange::Exchanges
  module Instantbitex
    module Services
      class Trades < Cryptoexchange::Services::Market

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output['trade_history'], market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Instantbitex::Market::API_URL}/tradehistory/#{market_pair.base}_#{market_pair.target}"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['tradeID']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Instantbitex::Market::NAME
            tr.type      = trade['type'].downcase
            tr.price     = trade['rate']
            tr.amount    = trade['amount']
            tr.timestamp = DateTime.parse(trade['tradetime']).to_time.to_i
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
