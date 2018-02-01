module Cryptoexchange::Exchanges
  module Zb
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Zb::Market::API_URL}/markets"

        def fetch
          output = super
          market_pairs = []
          output.each do |pair|
            pair_split = pair[0].split('_')
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: pair_split[0],
                              target: pair_split[1],
                              market: Zb::Market::NAME
                            )
          end
          market_pairs
        end

      end
    end
  end
end
