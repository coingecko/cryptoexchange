module Cryptoexchange::Exchanges
  module Coinpulse
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Coinpulse::Market::API_URL}/trades/#{market_pair.base}_#{market_pair.target}"
        end

        def adapt(output, market_pair)
          if output.key?('result') and !output['result'].to_a.empty?
            output['result'].collect do |trade|
              tr = Cryptoexchange::Models::Trade.new
              tr.trade_id  = trade['ID']
              tr.base      = market_pair.base
              tr.target    = market_pair.target
              tr.type      = trade['Type']
              tr.price     = trade['Price']
              tr.amount    = trade['Quantity']
              tr.timestamp = trade['Timestamp']
              tr.payload   = trade
              tr.market    = Coinpulse::Market::NAME
              tr
            end
          end
        end
      end
    end
  end
end
