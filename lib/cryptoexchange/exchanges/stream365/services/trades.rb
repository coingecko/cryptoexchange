module Cryptoexchange::Exchanges
  module Stream365
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output['trades'], market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Stream365::Market::API_URL}/api/trade/?pairing=#{market_pair.inst_id}"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['trade_id']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Stream365::Market::NAME
            tr.type      = trade['trade_type']
            tr.price     = trade['rate']
            tr.amount    = trade['amount']
            tr.timestamp = DateTime.parse(trade['trade_date']).to_time.to_i
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
