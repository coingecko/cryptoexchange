module Cryptoexchange::Exchanges
  module OkexSwap
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        def fetch
          output_swaps = fetch_via_api("https://www.okex.com/api/swap/v3/instruments")
          output_futures = fetch_via_api("https://www.okex.com/api/futures/v3/instruments")

          swaps = adapt(output_swaps)
          futures = adapt_futures(output_futures)

          swaps + futures
        end

        def adapt(output)
          output.map do |pair|
            base, target, expired_at = pair['instrument_id'].split "-"

            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: OkexSwap::Market::NAME,
              contract_interval: "perpetual",
              inst_id: pair['instrument_id']
            )
          end
        end

        def adapt_futures(output)
          output.map do |pair|
            base, target, expired_at = pair['instrument_id'].split "-"
            inst_id = pair['instrument_id']

            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: OkexSwap::Market::NAME,
              contract_interval: "futures",
              inst_id: inst_id
            )
          end
        end
      end
    end
  end
end
