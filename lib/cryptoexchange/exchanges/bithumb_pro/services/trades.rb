module Cryptoexchange::Exchanges
  module BithumbPro
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output["data"], market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::BithumbPro::Market::API_URL}/spot/trades?symbol=#{market_pair.base}-#{market_pair.target}"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.type      = trade['s']
            tr.price     = trade['p']
            tr.amount    = trade['v']
            tr.timestamp = trade['t'].to_i if !trade['t'].nil?
            tr.payload   = trade
            tr.market    = BithumbPro::Market::NAME
            tr
          end
        end
      end
    end
  end
end
