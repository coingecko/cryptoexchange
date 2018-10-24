module Cryptoexchange::Exchanges
  module Axnet
    module Services
      class Trades < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end
        
        def fetch(market_pair)
          output = super(trade_history_url(market_pair))
          adapt(output)
        end

        def trade_history_url(market_pair)
          base = market_pair.base
          target = market_pair.target
          "#{Cryptoexchange::Exchanges::Axnet::Market::API_URL}/return24Trades?market=#{base}_#{target}"
        end

        def adapt(output)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = nil
            tr.base      = trade['token']
            tr.target    = trade['basetoken']
            tr.type      = trade['type']
            tr.price     = trade['price']
            tr.amount    = trade['amount']
            tr.timestamp = trade['timestamp']
            tr.payload   = trade
            tr.market    = Axnet::Market::NAME
            tr
          end
        end
      end
    end
  end
end
