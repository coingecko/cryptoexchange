module Cryptoexchange::Exchanges
  module Decoin
    module Services
      class Trades < Cryptoexchange::Services::Market

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Decoin::Market::API_URL}/market/get-market-history/#{market_pair.base.upcase}-#{market_pair.target.upcase}"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Decoin::Market::NAME
            tr.price     = trade['Rate']
            tr.amount    = trade['Amount']
            tr.timestamp = Time.parse(trade['Date']).to_i
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
