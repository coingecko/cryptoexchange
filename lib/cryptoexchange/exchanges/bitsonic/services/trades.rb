module Cryptoexchange::Exchanges
  module Bitsonic
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output["result"], market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Bitsonic::Market::API_URL}/external/transaction/history?symbol=#{market_pair.base.downcase}#{market_pair.target.downcase}"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.type      = trade['isBuyerMaker'] == false ? 'buy' : 'sell'
            tr.price     = trade['price']
            tr.amount    = trade['qty']
            tr.timestamp = trade['time'].to_i / 1000
            tr.payload   = trade
            tr.market    = Bitsonic::Market::NAME
            tr
          end
        end
      end
    end
  end
end
