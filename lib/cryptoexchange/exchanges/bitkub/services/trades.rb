module Cryptoexchange::Exchanges
  module Bitkub
    module Services
      class Trades < Cryptoexchange::Services::Market
        TRADE_LIMIT = 20
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          base   = market_pair.base
          target = market_pair.target
          "#{Cryptoexchange::Exchanges::Bitkub::Market::API_URL}/market/trades?sym=#{target}_#{base}&lmt=#{TRADE_LIMIT}"
        end

        def adapt(output, market_pair)
          output['result'].collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Bitkub::Market::NAME
            tr.type      = trade[-1].downcase
            tr.price     = trade[1]
            tr.amount    = trade[2]
            tr.timestamp = trade[0]
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
