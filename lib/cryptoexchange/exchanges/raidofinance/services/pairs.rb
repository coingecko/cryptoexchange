module Cryptoexchange::Exchanges
  module Raidofinance
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Raidofinance::Market::API_URL}/assets"

        def fetch
          output = super
          output["data"]["rows"].map do |pair|
            base = pair['left']
            target = pair['right']
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Raidofinance::Market::NAME
            )
          end
        end
      end
    end
  end
end
