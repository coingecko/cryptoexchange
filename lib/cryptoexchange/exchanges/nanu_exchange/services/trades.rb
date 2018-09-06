module Cryptoexchange::Exchanges
  module NanuExchange
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::NanuExchange::Market::API_URL}=returnTradeHistory&currencyPair=#{market_pair.target}_#{market_pair.base}"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['id_trade']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = NanuExchange::Market::NAME
            tr.type      = trade['type']
            tr.price     = trade['price']
            tr.amount    = trade['amount']
            tr.timestamp = DateTime.parse(trade['created_at']).to_time.to_i
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
