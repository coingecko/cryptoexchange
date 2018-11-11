module Cryptoexchange::Exchanges
  module Biztranex
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          base   = market_pair.base
          target = market_pair.target
          "#{Cryptoexchange::Exchanges::Biztranex::Market::API_URL}/getmarkethistory?market=#{target}-#{base}"
        end

        def adapt(output, market_pair)
          output['result'].collect do |trade|
            tr          = Cryptoexchange::Models::Trade.new
            tr.trade_id = trade['Id']
            tr.base     = market_pair.base
            tr.target   = market_pair.target
            tr.type     = trade['OrderType'].downcase
            tr.price    = trade['Price']
            tr.amount   = trade['Quantity']
            tr.payload  = trade
            tr.market   = Biztranex::Market::NAME
            tr
          end
        end
      end
    end
  end
end
