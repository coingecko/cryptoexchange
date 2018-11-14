module Cryptoexchange::Exchanges
  module Crytrex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Crytrex::Market::API_URL}/pairs"

        def fetch
          output = super
          market_pairs = []
          output['result'].each do |pair|
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: pair['Currency'],
                              target: pair['Market'],
                              market: Crytrex::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
