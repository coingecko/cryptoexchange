module Cryptoexchange::Exchanges
  module Getbtc
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Getbtc::Market::API_URL}/transactions?currency=#{market_pair.target}"
        end

        def adapt(output, market_pair)
          trades = []
          output['transactions'].each_value do |trade|
            next unless trade['currency'] == market_pair.target

            tr = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Getbtc::Market::NAME
            tr.trade_id  = trade['id']
            tr.type      = trade['maker_type']
            tr.price     = trade['price']
            tr.amount    = trade['amount']
            tr.timestamp = trade['timestamp'].to_i
            tr.payload   = trade
            trades << tr
          end
          trades
        end
      end
    end
  end
end
