module Cryptoexchange::Exchanges
  module Bytex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bytex::Market::API_URL}/get_ticker?symbol=all"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['data'].map do |pair, _ticker|
            base, target = pair.split(/(USDT$)|(BTC$)/i)
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Bytex::Market::NAME
            )
          end
        end
      end
    end
  end
end
