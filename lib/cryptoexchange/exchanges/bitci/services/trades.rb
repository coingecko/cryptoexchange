module Cryptoexchange::Exchanges
  module Bitci
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "https://api.bitci.com/api/trades/BTC_TRY"
          "#{Cryptoexchange::Exchanges::Bitci::Market::API_URL}/trades/#{market_pair.base}_#{market_pair.target}"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['Id']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.type      = nil
            tr.price     = trade['Price']
            tr.amount    = trade['Qty']
            tr.timestamp = trade['Time'].to_i
            tr.payload   = trade
            tr.market    = Bitci::Market::NAME
            tr
          end
        end
      end
    end
  end
end
