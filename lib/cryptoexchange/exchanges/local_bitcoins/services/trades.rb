module Cryptoexchange::Exchanges
  module LocalBitcoins
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::LocalBitcoins::Market::API_URL}/bitcoincharts/#{market_pair.target.downcase}/trades.json"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['tid']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            # there is no type in respond, I've send mail to ask them
            # tr.type    = xxx
            tr.price     = trade['price']
            tr.amount    = trade['amount']
            tr.timestamp = trade['date']
            tr.payload   = trade
            tr.market    = LocalBitcoins::Market::NAME
            tr
          end
        end
      end
    end
  end
end
