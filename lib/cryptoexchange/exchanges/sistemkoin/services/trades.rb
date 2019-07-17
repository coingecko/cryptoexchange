module Cryptoexchange::Exchanges
  module Sistemkoin
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Sistemkoin::Market::API_URL}/tradehistory?symbol=#{market_pair.base}#{market_pair.target}&limit=50"
        end

        def adapt(output, market_pair)
          output['data'].map do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Sistemkoin::Market::NAME
            tr.type      = trade['type'] == 'ask' ? 'sell' : 'buy'
            tr.price     = trade['price'].to_f
            tr.amount    = trade['volume'].to_f
            tr.timestamp = trade['timestamp']
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
