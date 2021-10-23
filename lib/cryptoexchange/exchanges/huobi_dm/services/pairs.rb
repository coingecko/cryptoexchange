module Cryptoexchange::Exchanges
  module HuobiDm
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        def fetch
          output_swaps = fetch_via_api("#{Cryptoexchange::Exchanges::HuobiDm::Market::API_URL}/swap-api/v1/swap_contract_info")
          output_futures = fetch_via_api("#{Cryptoexchange::Exchanges::HuobiDm::Market::API_URL}/api/v1/contract_contract_info")

          swaps = adapt_swaps(output_swaps)
          futures = adapt_futures(output_futures)

          swaps + futures
        end

        def adapt_swaps(output)
          output["data"].map do |pair|
            base, target = pair['contract_code'].split "-"

            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              contract_interval: "perpetual",
              inst_id: pair['contract_code'],
              market: HuobiDm::Market::NAME,
            )
          end.compact
        end

        def adapt_futures(output)
          output['data'].map do |pair|
            target = "USD"
            interval_list = { "this_week"=> "weekly", "next_week"=> "biweekly", "quarter"=> "quarterly" }
            contract_interval = interval_list[pair["contract_type"]]

            interval_keys = { "weekly"=> "CW", "biweekly"=> "NW", "quarterly"=> "CQ" }
            inst_id = "#{pair['symbol']}_#{interval_keys[contract_interval]}"

            Cryptoexchange::Models::MarketPair.new({
              base: pair['symbol'],
              target: target,
              contract_interval: contract_interval,
              inst_id: inst_id,
              market: HuobiDm::Market::NAME
            })
          end
        end
      end
    end
  end
end
