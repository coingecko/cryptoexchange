module Cryptoexchange::Exchanges
  module Whitebit
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Whitebit::Market::API_URL}/markets"

        def fetch
          output = super
          market_pairs = []
          output['result'].each do |pair|
            base, target = pair['name'].split('_')
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              market: Whitebit::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
