module Cryptoexchange::Exchanges
  module Coinpark
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output['result'], market_pair)
        end

        def ticker_url(market_pair)
          base   = market_pair.base
          target = market_pair.target
          "#{Cryptoexchange::Exchanges::Coinpark::Market::API_URL}/mdata?cmd=deals&pair=#{base}_#{target}"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr           = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Coinpark::Market::NAME
            tr.trade_id  = trade['id']
            tr.price     = trade['price']
            tr.amount    = trade['amount']
            tr.type      = trade['side'] == 1 ? 'buy' : 'sell'
            tr.timestamp = trade['time'] / 1000
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
