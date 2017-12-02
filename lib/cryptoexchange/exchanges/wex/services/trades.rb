module Cryptoexchange::Exchanges
  module Wex
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Wex::Market::API_URL}/trades/#{symbol(market_pair)}"
        end

        def symbol(market_pair)
          "#{market_pair.base.downcase}_#{market_pair.target.downcase}"
        end

        def adapt(output, market_pair)
          data = output[symbol(market_pair)]

          data.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['tid']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.type      = trade['type']
            tr.price     = trade['price']
            tr.amount    = trade['amount']
            tr.timestamp = trade[:timestamp].to_i
            tr.payload   = trade
            tr.market    = Wex::Market::NAME
            tr
          end
        end
      end
    end
  end
end
