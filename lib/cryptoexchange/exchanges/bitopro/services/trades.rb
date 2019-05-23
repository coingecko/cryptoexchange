module Cryptoexchange::Exchanges
  module Bitopro
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Bitopro::Market::API_URL}/trades/#{market_pair.base}_#{market_pair.target}"
        end

        def adapt(output, market_pair)
          output["data"].collect do |trade|

            tr = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Bitopro::Market::NAME
            tr.price     = trade['price']
            tr.amount    = trade['amount']
            tr.timestamp = trade['timestamp'].to_i / 1000

            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
