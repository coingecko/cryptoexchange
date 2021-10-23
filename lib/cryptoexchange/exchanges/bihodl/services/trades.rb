module Cryptoexchange::Exchanges
  module Bihodl
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Bihodl::Market::API_URL}/latest-trade?symbol=#{market_pair.base}/#{market_pair.target}&size=100"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Bihodl::Market::NAME
            tr.type      = trade["direction"]
            tr.price     = trade["price"]
            tr.amount    = trade["amount"]
            tr.timestamp = trade["time"] / 1000
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
