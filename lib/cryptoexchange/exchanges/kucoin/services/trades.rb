module Cryptoexchange::Exchanges
  module Kucoin
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Kucoin::Market::API_URL}/open/deal-orders?symbol=#{market_pair.base}-#{market_pair.target}"
        end

        def adapt(output, market_pair)
          output['data'].collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.type      = trade[1].downcase
            tr.price     = trade[2]
            tr.amount    = trade[3]
            tr.timestamp = trade[0]/1000
            tr.payload   = trade
            tr.market    = Kucoin::Market::NAME
            tr
          end
        end
      end
    end
  end
end
