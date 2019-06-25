module Cryptoexchange::Exchanges
  module Xt
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Xt::Market::API_URL}/trades?marketName=#{market_pair.base.upcase}_#{market_pair.target.upcase}"
        end

        def adapt(output, market_pair)
          output['datas'].collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Xt::Market::NAME

            tr.type      = trade[4]
            tr.price     = trade[5]
            tr.amount    = trade[6]
            tr.timestamp = trade[2].to_i
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
