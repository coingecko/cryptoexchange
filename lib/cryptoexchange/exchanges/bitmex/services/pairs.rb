module Cryptoexchange::Exchanges
  module Bitmex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bitmex::Market::API_URL}/instrument/active"

        def fetch
          output = super
          market_pairs = []
          output.each do |pair|
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: pair['underlying'],
                              target: pair['quoteCurrency'],
                              market: Bitmex::Market::NAME
                            )
          end
          market_pairs
        end

      end
    end
  end
end
