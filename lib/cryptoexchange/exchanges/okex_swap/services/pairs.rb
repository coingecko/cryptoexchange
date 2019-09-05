module Cryptoexchange::Exchanges
  module OkexSwap
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::OkexSwap::Market::API_URL}/instruments"

        def fetch
          output_swaps = super
          swaps = adapt(output_swaps)

          output_futures = fetch_via_api("https://www.okex.com/api/futures/v3/instruments")
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
            )
          end
        end

        def adapt_futures(output)
          output.map do |pair|
            base, target, expired_at = pair['instrument_id'].split "-"
            inst_id = pair['instrument_id']

            interval = if pair["alias"] == "this_week"
              "weekly"
            elsif pair["alias"] == "next_week"
              "biweekly"
            elsif pair["alias"] == "quarter"
              "quarterly"
            end

            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: OkexSwap::Market::NAME,
              contract_interval: interval
            )
          end
        end
      end
    end
  end
end
