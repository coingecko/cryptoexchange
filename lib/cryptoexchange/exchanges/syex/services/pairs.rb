module Cryptoexchange::Exchanges
  module Syex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Syex::Market::API_URL}/selectCoinMarket?payCoinName=USDT"

        def fetch
          adapt(super)
        end

        def adapt(output)
          output['model'].map do |pair|
            Cryptoexchange::Models::MarketPair.new(
              base: pair['defaultenname'],
              target: Syex::Market::TARGET_SYM,
              market: Syex::Market::NAME
            )
          end
        end
      end
    end
  end
end
