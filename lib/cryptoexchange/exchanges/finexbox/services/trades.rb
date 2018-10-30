module Cryptoexchange::Exchanges
  module Finexbox
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output['result'], market_pair)
        end

        def ticker_url(market_pair)
          base   = market_pair.base.downcase
          target = market_pair.target.downcase
          "#{Cryptoexchange::Exchanges::Finexbox::Market::API_URL}/history?market=#{base}_#{target}&count=100"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr           = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.trade_id  = trade['id']
            tr.price     = trade['price']
            tr.amount    = trade['amount']
            tr.type      = trade['type']
            tr.timestamp = trade['timestamp']
            tr.payload   = trade
            tr.market    = Finexbox::Market::NAME
            tr
          end
        end
      end
    end
  end
end
