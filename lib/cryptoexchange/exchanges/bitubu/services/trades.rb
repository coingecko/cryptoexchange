module Cryptoexchange::Exchanges
  module Bitubu
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          base = market_pair.base.downcase
          target = market_pair.target.downcase
          "#{Cryptoexchange::Exchanges::Bitubu::Market::API_URL}/trades?market=#{base}#{target}"
        end

        def adapt(output, market_pair)
          output.map do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Bitubu::Market::NAME
            tr.type      = trade['type']
            tr.trade_id  = trade['id']
            tr.price     = trade['price']
            tr.amount    = trade["volume"].to_f
            tr.timestamp = Time.parse(trade['created_at']).to_i
            tr.payload   = trade

            tr
          end
        end
      end
    end
  end
end
