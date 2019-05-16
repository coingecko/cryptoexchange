module Cryptoexchange::Exchanges
  module Localbitcoins
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(trades_url(market_pair))
          adapt(output, market_pair)
        end

        def trades_url(market_pair)
          "#{Cryptoexchange::Exchanges::Localbitcoins::Market::API_URL}/bitcoincharts/#{market_pair.target}/trades.json"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['tid']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.type      = nil
            tr.price     = trade['price'].to_f
            tr.amount    = trade['amount'].to_f
            tr.timestamp = trade['date']
            tr.payload   = trade
            tr.market    = Localbitcoins::Market::NAME
            tr
          end
        end
      end
    end
  end
end
