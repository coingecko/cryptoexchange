module Cryptoexchange::Exchanges
  module Altilly
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Altilly::Market::API_URL}/public/symbol"

        def fetch
          output = super
          market_pairs = []
          output.each do |pair|
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: pair['baseCurrency'],
                              target: pair['quoteCurrency'],
                              market: Altilly::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
