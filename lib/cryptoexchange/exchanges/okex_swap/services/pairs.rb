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
            Cryptoexchange::Models::MarketPair.new(
              base:   pair['underlying_index'],
              target: pair['quote_currency'],
              market: OkexSwap::Market::NAME,
              inst_id: pair["instrument_id"],
              start_date: pair["listing"],
              expire_date: nil
            )
          end
        end

        def adapt_futures(output)
          output.map do |pair|
            Cryptoexchange::Models::MarketPair.new(
              base:   pair['underlying_index'],
              target: pair['quote_currency'],
              market: OkexSwap::Market::NAME,
              inst_id: pair["instrument_id"],
              start_date: pair["listing"],
              expire_date: pair["delivery"] 
            )
          end
        end
      end
    end
  end
end
