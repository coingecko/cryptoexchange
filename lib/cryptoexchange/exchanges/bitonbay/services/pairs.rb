module Cryptoexchange::Exchanges
  module Bitonbay
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bitonbay::Market::API_URL}/api-public-ticker"

        def fetch
          output = super
          market_pairs = []
          output.each do |pair|
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: pair['zone_type'],
                              target: pair['currency_type'],
                              market: Bitonbay::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
