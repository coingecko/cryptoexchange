module Cryptoexchange::Exchanges
  module Paribu
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Paribu::Market::API_URL}/ticker"

        def fetch
          output = super

          output.keys.map do |pair|
            base, target = pair.split("_")
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Paribu::Market::NAME
            )
          end
        end
      end
    end
  end
end
