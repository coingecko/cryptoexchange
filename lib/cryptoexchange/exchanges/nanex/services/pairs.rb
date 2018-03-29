module Cryptoexchange::Exchanges
  module Nanex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Nanex::Market::API_URL}/public/tickers"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.collect do |_pair, value|
            base = value['quote']
            target = value['base']
            market_pair = Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Nanex::Market::NAME
            )
          end
        end
      end
    end
  end
end
