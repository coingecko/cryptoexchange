module Cryptoexchange::Exchanges
  module Zebpay
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Zebpay::Market::API_URL}/market/#{market_pair.base.downcase}-#{market_pair.target.downcase}/trades"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade["trans_id"]
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Zebpay::Market::NAME
            tr.type      = trade["fill_flags"] == 1 ? "sell" : "buy"
            tr.price     = trade["fill_price"]
            tr.amount    = trade["fill_qty"]
            tr.timestamp = trade["lastModifiedDate"].to_i/1000
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
