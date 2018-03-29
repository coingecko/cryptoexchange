module Cryptoexchange::Exchanges
  module Cryptopia
    module Services
      class Trades < Cryptoexchange::Services::Market
        HOURS = 24

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Cryptopia::Market::API_URL}/GetMarketHistory/#{market_pair.base}_#{market_pair.target}/#{HOURS}"
        end

        def adapt(output, market_pair)
          (output['Data'] || []).collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = nil
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Cryptopia::Market::NAME
            tr.type      = trade['Type'].to_s.downcase
            tr.price     = trade['Price']
            tr.amount    = trade['Amount']
            tr.timestamp = trade['Timestamp'].to_i
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
