module Cryptoexchange::Exchanges
  module Coineal
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Coineal::Market::API_URL}/common/symbols"

        def fetch
          output = super
          market_pairs = []
          output['data'].each do |pair|
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: pair['base_coin'].upcase,
                              target: pair['count_coin'].upcase,
                              market: Coineal::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
