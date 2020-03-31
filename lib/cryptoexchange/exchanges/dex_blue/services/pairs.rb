module Cryptoexchange::Exchanges
  module DexBlue
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::DexBlue::Market::API_URL}/listed"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output["data"]["markets"].map do |_, pair|
            Cryptoexchange::Models::MarketPair.new(
              base: pair["traded"],
              target: pair["quote"],
              market: DexBlue::Market::NAME
            )
          end
        end
      end
    end
  end
end
