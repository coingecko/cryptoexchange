module Cryptoexchange::Exchanges
  module Bitflip
    module Services
      class Trades < Cryptoexchange::Services::Market

        def fetch(market_pair)
          pair_combined = "#{market_pair.base.downcase}:#{market_pair.target.downcase}"
          raw_output = HTTP.post(tradebook_url, :body => "{\"pair\":\"#{pair_combined}\"}")
          output = JSON.parse(raw_output)
          adapt(output[1], market_pair)
        end

        def tradebook_url
          "#{Cryptoexchange::Exchanges::Bitflip::Market::API_URL}market.getTrades"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['id']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Bitflip::Market::NAME
            tr.type      = trade['type']
            tr.price     = trade['price']
            tr.amount    = trade['amount']
            tr.timestamp = trade['timestamp'].to_i
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
