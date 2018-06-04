module Cryptoexchange::Exchanges
  module Openledger
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          base   = market_pair.base
          target = market_pair.target
          "#{Cryptoexchange::Exchanges::Openledger::Market::API_URL}/trades?market=#{base}_#{target}"
        end

        def adapt(output, market_pair)
          output['result'].collect do |trade|
            tr           = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Openledger::Market::NAME
            tr.trade_id  = trade['ID']
            tr.type      = trade['Type'] == 'BUY' ? 'buy' : 'sell'
            tr.price     = trade['Price']
            tr.amount    = trade['Quantity']
            tr.timestamp = trade['Timestamp'].to_i
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
