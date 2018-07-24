module Cryptoexchange::Exchanges
  module Icoinbay
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Icoinbay::Market::API_URL}/v1/trades?since=600&symbol=#{market_pair.base.downcase}_#{market_pair.target.downcase}"
        end

        def adapt(output, market_pair)
          output['body'].collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Icoinbay::Market::NAME
            tr.type      = trade['0'] ? 'buy' : 'sell'
            tr.price     = NumericHelper.to_d(trade['price'])
            tr.amount    = NumericHelper.to_d(trade['amount'])
            tr.timestamp = trade['date_ms']/1000
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
