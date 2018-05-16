module Cryptoexchange::Exchanges
  module Heat
    module Services
      class Trades < Cryptoexchange::Services::Market

        def fetch(market_pair)
          base, target = IdFetcher.get_id(market_pair.base.upcase, market_pair.target.upcase)
          output = super(ticker_url(base, target))
          adapt(output, market_pair)
        end

        def ticker_url(base, target)
          "#{Cryptoexchange::Exchanges::Heat::Market::API_URL}/trade/#{target.to_i}/#{base.to_i}/0/100"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = {ask_id: trade['askOrder'], bid_id: trade['bidOrder']}
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.type      = trade['isBuy'] == true ? 'buy' : 'sell'
            tr.price     = trade['price']
            tr.amount    = trade['quantity']
            tr.timestamp = trade['timestamp']
            tr.payload   = trade
            tr.market    = Heat::Market::NAME
            tr
          end
        end
      end
    end
  end
end
