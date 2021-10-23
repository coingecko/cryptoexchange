module Cryptoexchange::Exchanges
  module Bhex
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          base = market_pair.base
          target = market_pair.target
          "#{Cryptoexchange::Exchanges::Bhex::Market::API_URL}/trades?symbol=#{base.upcase}#{target.upcase}"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.type      = trade['isBuyerMaker'] ? "sell" : "buy"
            tr.price     = trade['price'].to_f
            tr.amount    = trade['qty'].to_f
            tr.timestamp = trade['time'].to_i / 1000
            tr.payload   = trade
            tr.market    = Bhex::Market::NAME
            tr
          end
        end
      end
    end
  end
end
