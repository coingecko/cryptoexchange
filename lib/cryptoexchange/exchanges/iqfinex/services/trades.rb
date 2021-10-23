module Cryptoexchange::Exchanges
  module Iqfinex
    module Services
      class Trades < Cryptoexchange::Services::Market

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          base   = market_pair.base
          target = market_pair.target
          "#{Cryptoexchange::Exchanges::Iqfinex::Market::API_URL}/v1/trades/#{base}#{target}?sort=DESC"
        end

        def adapt(output, market_pair)
          output['data']['rows'].collect do |trade|
            tr           = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['id']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Iqfinex::Market::NAME
            tr.type      = trade['type']
            tr.price     = trade['price']
            tr.amount    = trade['volume']
            tr.timestamp = trade['close_time']
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
