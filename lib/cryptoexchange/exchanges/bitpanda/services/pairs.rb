module Cryptoexchange::Exchanges
  module Bitpanda
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bitpanda::Market::API_URL}/instruments"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |pair|
            next unless pair['state'] == 'ACTIVE'
            Cryptoexchange::Models::MarketPair.new(
              base:   pair["base"]["code"],
              target: pair["quote"]["code"],
              market: Bitpanda::Market::NAME
            )
          end.compact
        end
      end
    end
  end
end
