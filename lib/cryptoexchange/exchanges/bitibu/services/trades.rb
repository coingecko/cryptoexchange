module Cryptoexchange::Exchanges
  module Bitibu
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          base = market_pair.base.downcase
          target = market_pair.target.downcase
          "#{Cryptoexchange::Exchanges::Bitibu::Market::API_URL}/trades.json?market=#{base}#{target}"
        end

        def adapt(output, market_pair)
          output.map do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Bitibu::Market::NAME

            tr.trade_id  = trade['id']
            tr.price     = trade['price']
            tr.timestamp = Time.parse(trade['created_at']).to_i
            tr.payload   = trade
            
            tr
          end
        end
      end
    end
  end
end
