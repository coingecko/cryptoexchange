module Cryptoexchange::Exchanges
  module TraderOne
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          trades = output['result']
          adapt(trades['orders'], market_pair)
        end

        def ticker_url(market_pair)
          market = "#{market_pair.base}-#{market_pair.target}"
          "#{Cryptoexchange::Exchanges::TraderOne::Market::API_URL}/orders/listOrders?market=#{market}&status=filled"
        end

        def adapt(trades, market_pair)
          trades.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.type      = trade['side']
            tr.price     = trade['price'].to_f
            tr.amount    = trade['amount'].to_f
            tr.timestamp = trade['updatedAt'].to_i / 1000
            tr.payload   = trade
            tr.market    = TraderOne::Market::NAME
            tr
          end
        end
      end
    end
  end
end

