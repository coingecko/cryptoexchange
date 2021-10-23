module Cryptoexchange::Exchanges
  module Beaxy
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Beaxy::Market::API_URL}/symbols"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |pair|
            Cryptoexchange::Models::MarketPair.new(
              base:   pair["baseCurrency"],
              target: pair["termCurrency"],
              market: Beaxy::Market::NAME
            )
          end
        end
      end
    end
  end
end
