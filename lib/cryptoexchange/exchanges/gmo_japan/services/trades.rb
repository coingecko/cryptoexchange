module Cryptoexchange::Exchanges
  module GmoJapan
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::GmoJapan::Market::API_URL}/trades?symbol=#{market_pair.base}"
        end

        def adapt(output, market_pair)
          output = output["data"]["list"]
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.type      = trade['side'].downcase
            tr.price     = trade['price']
            tr.amount    = trade['size']
            tr.timestamp = Time.parse(trade['timestamp']).to_i
            tr.payload   = trade
            tr.market    = GmoJapan::Market::NAME
            tr
          end
        end
      end
    end
  end
end
