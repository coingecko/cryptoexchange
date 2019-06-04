module Cryptoexchange::Exchanges
  module Piexgo
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          market_pair = "#{market_pair.base.upcase}_#{market_pair.target.upcase}"
          "#{Cryptoexchange::Exchanges::Piexgo::Market::API_URL}/api/v1/trades?symbol=#{market_pair}"
        end

        def adapt(output, market_pair)
          output["data"].collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.type      = if trade['direct'].to_i == 0
                             "buy"
                           elsif trade['direct'].to_i == 1
                             "sell"
                           end
            tr.price     = trade['price']
            tr.amount    = trade['vol']
            tr.timestamp = trade['time'].to_i / 1000
            tr.payload   = trade
            tr.market    = Piexgo::Market::NAME
            tr
          end
        end
      end
    end
  end
end
