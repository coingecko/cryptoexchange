module Cryptoexchange::Exchanges
  module DexBlue
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::DexBlue::Market::API_URL}/market/#{market_pair.base.upcase}#{market_pair.target.upcase}/trades"
        end

        def adapt(output, market_pair)
          output['data']['trades'].collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['id']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = DexBlue::Market::NAME
            tr.type      = trade['direction'].downcase
            tr.price     = NumericHelper.to_d trade['rate']
            tr.amount    = NumericHelper.to_d(trade['amount']) / 1000000000000000000
            tr.timestamp = trade['timestamp'].to_i / 1000
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
