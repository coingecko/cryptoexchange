module Cryptoexchange::Exchanges
  module Tideal
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Tideal::Market::API_URL}/markets.json"

        def fetch
          output = super
          market_pairs = []
          output.each do |pair|
            base, target = pair['name'].split('/')
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              market: Tideal::Market::NAME
                            )
          end
          market_pairs
        end

      end
    end
  end
end
