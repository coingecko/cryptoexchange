module Cryptoexchange::Exchanges
  module Vaultmex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Vaultmex::Market::API_URL}/market/summary"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |pair|
            Cryptoexchange::Models::MarketPair.new(
              base:   pair['code'],
              target: pair['exchange'],
              market: Vaultmex::Market::NAME
            )
          end
        end
      end
    end
  end
end
