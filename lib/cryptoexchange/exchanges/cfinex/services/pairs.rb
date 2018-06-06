module Cryptoexchange::Exchanges
  module Cfinex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Cfinex::Market::API_URL}/tickerapi"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |pair, ticker|
            next if ticker['isFrozen'] == 1
            base, target = pair.split('_')
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Cfinex::Market::NAME
            )
          end.compact
        end
      end
    end
  end
end
