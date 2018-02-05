module Cryptoexchange::Exchanges
  module Bitbank
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          base = market_pair.base.downcase
          target = market_pair.target.downcase
          "#{Cryptoexchange::Exchanges::Bitbank::Market::API_URL}/#{base}_#{target}/transactions"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['transaction_id']
            tr.type = trade['side']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.price     = trade['price']
            tr.amount    = trade['amount']
            tr.timestamp = trade['executed_at'].to_i
            tr.payload   = trade
            tr.market    = Bitbank::Market::NAME
            tr
          end
        end
      end
    end
  end
end
