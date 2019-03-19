module Cryptoexchange::Exchanges
  module Chaoex
    module Services
      class Trades < Cryptoexchange::Services::Market
        TRADES_LIMIT = "20"

        def fetch(market_pair)
          pairs = Cryptoexchange::Exchanges::Chaoex::Services::Pairs.new.fetch
          pair = pairs.select { |pair| pair.base == market_pair.base && pair.target == market_pair.target }.first
          output = super(ticker_url(pair))
          adapt(output, market_pair)
        end

        def ticker_url(pair)
          base_id, target_id = pair.inst_id.split("-")
          "#{Cryptoexchange::Exchanges::Chaoex::Market::API_URL}/quote/tradeHistory?baseCurrencyId=#{target_id}&tradeCurrencyId=#{base_id}&limit=#{TRADES_LIMIT}"
        end

        def adapt(output, market_pair)
          output['attachment'].collect do |trade|
            tr           = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['tid']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Chaoex::Market::NAME
            tr.type      = trade['type']
            tr.price     = trade['price']
            tr.amount    = trade['amount']
            tr.timestamp = trade['date'].to_i / 1000
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
