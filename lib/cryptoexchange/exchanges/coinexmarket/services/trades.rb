module Cryptoexchange::Exchanges
  module Coinexmarket
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output['data'], market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Coinexmarket::Market::API_URL}/tradeHistory/#{market_pair.base}_#{market_pair.target}"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['id']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.price     = trade['coincost'].to_f/trade['coins'].to_f
            tr.amount    = trade['coins']
            tr.timestamp = Time.now.to_i
            tr.payload   = trade
            tr.market    = Coinexmarket::Market::NAME
            tr
          end
        end
      end
    end
  end
end
