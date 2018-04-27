module Cryptoexchange::Exchanges
  module Kkcoin
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Kkcoin::Market::API_URL}/trades?symbol=#{market_pair.base_raw}_#{market_pair.target_raw}"
        end

        # [
        #   1519365636000,  // Timestamp      -> 0
        #   "0.00000526",   // Price          -> 1
        #   "6419",         // Amount         -> 2
        #   true            // Maker is buyer -> 3
        # ]

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = nil
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.type      = trade[3] ? 'buy' : 'sell'
            tr.price     = trade[1]
            tr.amount    = trade[2]
            tr.timestamp = trade[0] / 1000
            tr.payload   = trade
            tr.market    = Kkcoin::Market::NAME
            tr
          end
        end
      end
    end
  end
end
