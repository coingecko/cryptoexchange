module Cryptoexchange::Exchanges
  module Paradex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Paradex::Market::API_URL}/v0/markets"

        def fetch
          output = Cryptoexchange::Exchanges::Paradex::Market.fetch_via_api(PAIRS_URL)
          output.map do |pair|
            Cryptoexchange::Models::MarketPair.new(
              base:   pair['baseToken'],
              target: pair['quoteToken'],
              market: Paradex::Market::NAME
            )
          end
        end
      end
    end
  end
end
