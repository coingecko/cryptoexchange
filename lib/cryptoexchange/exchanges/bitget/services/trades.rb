module Cryptoexchange::Exchanges
  module Bitget
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          base   = market_pair.base
          target = market_pair.target
          "#{Cryptoexchange::Exchanges::Bitget::Market::API_URL}/market/trade?symbol=#{base}_#{target}"
        end

        def adapt(output, market_pair)
          output['data']['data'].collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['id']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Bitget::Market::NAME
            tr.type      = trade['direction'].downcase
            tr.price     = trade['price']
            tr.amount    = trade['amount']
            tr.timestamp = trade['ts'].to_i / 1000
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
