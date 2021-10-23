module Cryptoexchange::Exchanges
  module Vcc
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Vcc::Market::API_URL}/trades/#{market_pair.base.downcase}_#{market_pair.target.downcase}"
        end

        def adapt(output, market_pair)
          output['data'].collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['trade_id']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Vcc::Market::NAME
            tr.type      = trade['type']
            tr.price     = trade['price']
            tr.amount    = trade['base_volume']
            tr.timestamp = trade['trade_timestamp'].to_i / 1000
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
