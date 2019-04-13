module Cryptoexchange::Exchanges
  module Deex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Deex::Market::API_URL}/api/v1/markets"

        def fetch
          output = super
          market_pairs = []
          output['result'].each do |pair|
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: pair['BaseCurrency'],
                              target: pair['MarketCurrency'],
                              market: Deex::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
