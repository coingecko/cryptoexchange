module Cryptoexchange::Exchanges
  module Bitmax
    module Services
      class Trades < Cryptoexchange::Services::Market

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          base   = market_pair.base
          target = market_pair.target
          "#{Cryptoexchange::Exchanges::Bitmax::Market::API_URL}/trades?symbol=#{base}-#{target}"
        end

        def adapt(output, market_pair)
          output['trades'].collect do |trade|
            tr           = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Bitmax::Market::NAME
            tr.type      = trade['bm'] == true ? 'sell' : 'buy'
            tr.price     = trade['p']
            tr.amount    = trade['q']
            tr.timestamp = trade['t'] / 1000
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
