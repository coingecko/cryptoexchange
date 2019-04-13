module Cryptoexchange::Exchanges
  module TokensNet
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          base   = market_pair.base.downcase
          target = market_pair.target.downcase
          "#{Cryptoexchange::Exchanges::TokensNet::Market::API_URL}/public/trades/day/#{base}#{target}/"
        end

        def adapt(output, market_pair)
          output['trades'].collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.trade_id  = trade['id']
            tr.type      = trade['type']
            tr.price     = trade['price']
            tr.amount    = trade['amount']
            tr.timestamp = trade['datetime']
            tr.payload   = trade
            tr.market    = TokensNet::Market::NAME
            tr
          end
        end
      end
    end
  end
end
