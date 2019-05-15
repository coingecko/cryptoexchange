module Cryptoexchange::Exchanges
  module Fatbtc
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output['trades'], market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Fatbtc::Market::API_URL}/trade/#{market_pair.base}#{market_pair.target}/50/0"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Fatbtc::Market::NAME
            tr.type      = trade['taker']
            tr.price     = trade['price']
            tr.amount    = trade['volume']
            tr.timestamp = trade['timestamp']/1000
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
