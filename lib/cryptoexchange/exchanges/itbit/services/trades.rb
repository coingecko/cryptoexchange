module Cryptoexchange::Exchanges
  module Itbit
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Itbit::Market::API_URL}/markets/#{market_pair.base}#{market_pair.target}/trades"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Itbit::Market::NAME

            tr.trade_id  = trade['recentTrades']['matchNumber']
            tr.price     = trade['recentTrades']['price']
            tr.amount    = trade['recentTrades']['amount']
            tr.timestamp = DateTime.strptime(trade['recentTrades']['timestamp'],'%FT%T').to_time.to_i
            tr.payload   = trade
            
            tr
          end
        end
      end
    end
  end
end
