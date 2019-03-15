module Cryptoexchange::Exchanges
  module OkexSwap
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::OkexSwap::Market::API_URL}/instruments"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |pair|
            base, target, expired_at = pair['instrument_id'].split "-"

            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: OkexSwap::Market::NAME,
              contract_interval: "perpetual",
            )
          end
        end

      end
    end
  end
end
