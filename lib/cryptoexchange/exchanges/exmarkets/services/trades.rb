module Cryptoexchange::Exchanges
  module Exmarkets
    module Services
      class Trades < Cryptoexchange::Services::Market
        URL = "#{Cryptoexchange::Exchanges::Exmarkets::Market::API_URL}/transactions"
        LIMIT = 50

        def fetch(market_pair)
          output = super(trades_url(market_pair))
          adapt(output, market_pair)
        end

        def trades_url(market_pair)
          base   = market_pair.base
          target = market_pair.target

          "#{URL}?market=#{base}-#{target}&limit=#{LIMIT}".downcase
        end

        def adapt(output, market_pair)
          output['transactions'].collect do |transaction|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = transaction['id']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Exmarkets::Market::NAME
            tr.type      = transaction['side']
            tr.price     = NumericHelper.to_d(transaction['price'])
            tr.amount    = NumericHelper.to_d(transaction['amount'])
            tr.timestamp = NumericHelper.to_d(transaction['timestamp'])
            tr.payload   = transaction
            tr
          end
        end
      end
    end
  end
end
