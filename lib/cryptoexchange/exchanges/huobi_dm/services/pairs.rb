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
            interval_list = { "this_week"=> "weekly", "next_week"=> "biweekly", "quarter"=> "quarterly" }
            contract_interval = interval_list[pair["contract_type"]]

            Cryptoexchange::Models::MarketPair.new({
              base: pair['symbol'],
              target: target,
              contract_interval: contract_interval,
              market: HuobiDm::Market::NAME
            })
          end
        end
      end
    end
  end
end
