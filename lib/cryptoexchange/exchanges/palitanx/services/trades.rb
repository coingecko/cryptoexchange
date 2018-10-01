module Cryptoexchange::Exchanges
  module Palitanx
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output['result'], market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Palitanx::Market::API_URL}/getmarkethistory/#{market_pair.base}-#{market_pair.target}"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Palitanx::Market::NAME
            tr.type      = trade['OrderType'].downcase
            tr.price     = trade['Price']
            tr.amount    = trade['Quantity']
            tr.timestamp = DateTime.parse(trade['TimeStamp']).to_time.to_i
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
