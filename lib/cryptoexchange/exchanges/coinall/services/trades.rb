module Cryptoexchange::Exchanges
  module Coinall
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Coinall::Market::API_URL}/spot/v3/products/#{market_pair.base}-#{market_pair.target}/trades?limit=100"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['trade_id']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Coinall::Market::NAME
            tr.type      = trade['side']
            tr.price     = trade['price']
            tr.amount    = trade['size']
            tr.timestamp = DateTime.parse(trade['time']).to_time.to_i
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
