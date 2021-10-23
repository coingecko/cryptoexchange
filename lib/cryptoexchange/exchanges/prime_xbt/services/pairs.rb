module Cryptoexchange::Exchanges
  module PrimeXbt
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::PrimeXbt::Market::API_URL}/markets?category=crypto"

        def fetch
          output = super
          market_pairs = []
          output['data'].each do |pair|
            base, target = pair['base'], pair['quote']
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              inst_id: pair['name'],
                              market: PrimeXbt::Market::NAME
                            )
          end.compact
          market_pairs
        end
      end
    end
  end
end
