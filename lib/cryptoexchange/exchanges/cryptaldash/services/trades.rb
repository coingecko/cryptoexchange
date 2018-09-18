module Cryptoexchange::Exchanges
  module Cryptaldash
    module Services
      class Trades < Cryptoexchange::Services::Market

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output['trades'], market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Cryptaldash::Market::API_URL}/tradehistory/#{market_pair.base.downcase}#{market_pair.target.downcase}"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Cryptaldash::Market::NAME
            tr.type      = trade['side'].downcase
            tr.price     = trade['price']
            tr.amount    = trade['quantity']
            tr.timestamp = Time.now.to_i
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
