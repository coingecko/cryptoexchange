module Cryptoexchange::Exchanges
  module Coindcx
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          base   = market_pair.base
          target = market_pair.target
          "#{Cryptoexchange::Exchanges::Coindcx::Market::API_URL}/exchange/v1/trades/#{target}#{base}"
        end

        def adapt(output, market_pair)
          output['trade_data'].collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Coindcx::Market::NAME

            tr.price     = trade['p']
            tr.amount    = trade['q']
            tr.timestamp = trade['T'].to_i / 1000

            tr.payload   = trade

            tr
          end
        end
      end
    end
  end
end
