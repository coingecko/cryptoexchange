module Cryptoexchange::Exchanges
  module Acx
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          base = market_pair.base.downcase
          target = market_pair.target.downcase
          "#{Cryptoexchange::Exchanges::Acx::Market::API_URL}/trades.json?market=#{base}#{target}"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['id']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.price     = trade['volume']
            tr.amount    = trade['funds']

            timestamp = DateTime.iso8601(trade['created_at'])
                                .to_time
                                .to_i

            tr.timestamp = timestamp
            tr.payload   = trade
            tr.market    = Acx::Market::NAME
            tr
          end
        end
      end
    end
  end
end
