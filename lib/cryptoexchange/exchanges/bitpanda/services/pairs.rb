module Cryptoexchange::Exchanges
  module Bitpanda
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bitpanda::Market::API_URL}/market-ticker"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |pair|
            next unless pair['state'] == 'ACTIVE'
            base, target = pair["instrument_code"].split("_")

            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Bitpanda::Market::NAME
            )
          end.compact
        end
      end
    end
  end
end
