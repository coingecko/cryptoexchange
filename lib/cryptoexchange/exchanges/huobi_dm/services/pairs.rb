module Cryptoexchange::Exchanges
  module HuobiDm
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::HuobiDm::Market::API_URL}/api/v1/contract_contract_info"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['data'].map do |pair|
            target = "USD"

            interval_keys = { "this_week"=> "CW", "next_week"=> "NW", "quarter"=> "CQ" }
            interval = interval_keys[pair['contract_type']]

            Cryptoexchange::Models::MarketPair.new({
              base: pair['symbol'],
              target: target,
              inst_id: pair['symbol'] + "_" + interval,
              market: HuobiDm::Market::NAME
            })
          end
        end
      end
    end
  end
end
