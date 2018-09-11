module Cryptoexchange::Exchanges
  module Everbloom
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Everbloom::Market::API_URL}/markets"

        def fetch
          output = super
          market_pairs = []
          output['data'].each do |pair|
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: pair['name'],
                              target: 'ETH',
                              inst_id: pair['id'],
                              market: Everbloom::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
