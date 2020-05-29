module Cryptoexchange::Exchanges
  module StakeCube
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::StakeCube::Market::API_URL}/exchange/trades?base=#{market_pair.target}&target=#{market_pair.base}"
        end

        def adapt(output, market_pair)
          output.map do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.type      = trade['type']
            tr.price     = trade['PRICE']
            tr.amount    = trade['amount']
            tr.timestamp = DateTime.parse(trade['timestamp']).to_time.to_i
            tr.payload   = trade
            tr.market    = StakeCube::Market::NAME
            tr
          end
        end
      end
    end
  end
end
