module Cryptoexchange::Exchanges
  module MaxMaicoin
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          market = "#{market_pair.base}#{market_pair.target}".downcase
          "#{Cryptoexchange::Exchanges::MaxMaicoin::Market::API_URL}/trades?market=#{market}&order_by=desc&pagination=true&page=1&limit=50&offset=0"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = MaxMaicoin::Market::NAME

            tr.trade_id  = trade['id']
            tr.type      = trade['side']
            tr.price     = trade['price']
            tr.amount    = trade['volume']
            tr.timestamp = trade['created_at'].to_i
            tr.payload   = trade
            
            tr
          end
        end
      end
    end
  end
end
