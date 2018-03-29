module Cryptoexchange::Exchanges
  module Bibox
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          base = market_pair.base
          target = market_pair.target
          "#{Cryptoexchange::Exchanges::Bibox::Market::API_URL}/mdata?cmd=deals&pair=#{base}_#{target}&size=15"
        end

        def adapt(output, market_pair)
          trades = output['result']
          trades.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.type      = trade['side'] == 2 ? "sell" : "buy"
            tr.price     = trade['price']
            tr.amount    = trade['amount']
            tr.timestamp = trade['time'].to_i / 1000
            tr.payload   = trade
            tr.market    = Bibox::Market::NAME
            tr
          end
        end
      end
    end
  end
end
