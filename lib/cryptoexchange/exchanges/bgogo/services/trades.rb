module Cryptoexchange::Exchanges
  module Bgogo
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = Bgogo::Market.ticker_fetch(trades_url(market_pair))
          adapt(output, market_pair)
        end

        def trades_url(market_pair)
          base   = market_pair.base
          target = market_pair.target
          "#{Cryptoexchange::Exchanges::Bgogo::Market::API_URL}/snapshot/#{base}/#{target}"
        end

        def adapt(output, market_pair)
          trades = output['trade_history']
          trades.collect do |trade|
            tr           = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.type      = trade['side']
            tr.price     = trade['price']
            tr.amount    = trade['amount']
            tr.timestamp = trade['time'].to_i
            tr.payload   = trade
            tr.market    = Bgogo::Market::NAME
            tr
          end
        end
      end
    end
  end
end
