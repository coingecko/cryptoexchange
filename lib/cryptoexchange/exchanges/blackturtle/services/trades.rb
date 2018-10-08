module Cryptoexchange::Exchanges
  module Blackturtle
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Blackturtle::Market::API_URL}/trades/#{market_pair.base}/#{market_pair.target}/100"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
           if trade['confirmed'] == true
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['id']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Blackturtle::Market::NAME
            tr.type      = trade['type']
            tr.price     = trade['price']
            tr.amount    = trade['amount']
            tr.timestamp = trade['timestamp']/1000
            tr.payload   = trade
            tr
           end
          end
        end
      end
    end
  end
end
