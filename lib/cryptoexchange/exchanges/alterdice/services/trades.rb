module Cryptoexchange::Exchanges
  module Alterdice
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          base = market_pair.base.downcase
          target = market_pair.target.downcase
          "#{Cryptoexchange::Exchanges::Alterdice::Market::API_URL}/deals?symbol=#{base}#{target}"
        end

        def adapt(output, market_pair)
          output.collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Alterdice::Market::NAME

            tr.type      = trade['direction']
            tr.price     = trade['price']
            tr.amount    = trade['amount']
            tr.timestamp = trade['trade_date'].to_i / 1000
            tr.payload   = trade

            tr
          end
        end
      end
    end
  end
end
