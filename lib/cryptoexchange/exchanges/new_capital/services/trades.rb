module Cryptoexchange::Exchanges
  module NewCapital
    module Services
      class Trades < Cryptoexchange::Services::Market

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          base = market_pair.base.upcase
          target = market_pair.target.upcase
          "#{Cryptoexchange::Exchanges::NewCapital::Market::API_URL}/trades?symbol=#{base}_#{target}"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id = trade['id']
            tr.base = market_pair.base
            tr.target = market_pair.target
            tr.market = NewCapital::Market::NAME
            tr.price = trade['price']
            tr.amount = trade['qty']
            tr.timestamp = trade['time']
            tr.payload = trade
            tr
          end
        end
      end
    end
  end
end
