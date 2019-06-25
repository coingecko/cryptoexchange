module Cryptoexchange::Exchanges
  module Satoexchange
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          market_pair = Cryptoexchange::Exchanges::Satoexchange::Market.assign_inst_id(market_pair) if market_pair.inst_id.nil?
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Satoexchange::Market::API_URL}/get_market_history/?market_id=#{market_pair.inst_id}"
        end

        def adapt(output, market_pair)
          output['history'].map do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Satoexchange::Market::NAME
            tr.type      = trade['type']
            tr.price     = trade['price']
            tr.amount    = trade['amount']
            tr.timestamp = DateTime.parse(trade['created_date']).to_time.to_i
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
