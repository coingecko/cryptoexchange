module Cryptoexchange::Exchanges
  module Crex24
    module Services
      class Trades < Cryptoexchange::Services::Market
        COUNTS = 1000

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Crex24::Market::API_URL}/ReturnTradeHistoryPub?request=[PairName=#{market_pair.target}_#{market_pair.base}][Count=#{COUNTS}]"
        end

        def adapt(output, market_pair)
          output['Trades'].collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = trade['Id']
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Crex24::Market::NAME
            tr.type      = trade['IsSell'] ? "sell" : "buy"
            tr.price     = trade['CoinPrice']
            tr.amount    = trade['CoinCount']
            tr.timestamp = trade['DtCreateTS'].to_i
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
