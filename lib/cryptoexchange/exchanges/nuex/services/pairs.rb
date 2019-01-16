module Cryptoexchange::Exchanges
  module Nuex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Nuex::Market::API_URL}/exchangeInfo"

        def fetch
          output = super
          market_pairs = []
          output['symbols'].each do |pair|
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: pair['baseAsset'],
                              target: pair['quoteAsset'],
                              market: Nuex::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
