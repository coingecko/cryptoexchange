module Cryptoexchange::Exchanges
  module Ooobtc
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          base = market_pair.base.downcase
          target = market_pair.target.downcase
          "#{Cryptoexchange::Exchanges::Ooobtc::Market::API_URL}/getorderhistory?kv=#{base}_#{target}"
        end

        def adapt(output, market_pair)
          output['data'].collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Ooobtc::Market::NAME
            tr.type      = trade['ordertype']
            tr.price     = trade['price']
            tr.amount    = trade['number']
            tr.timestamp = Time.parse(trade['time']).to_i
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
