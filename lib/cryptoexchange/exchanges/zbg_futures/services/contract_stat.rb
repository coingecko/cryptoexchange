module Cryptoexchange::Exchanges
  module ZbgFutures
    module Services
      class ContractStat < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          adapt(market_pair)
        end

        def adapt(market_pair)
          contract_stat = Cryptoexchange::Models::ContractStat.new

          contract_stat.base      = market_pair.base
          contract_stat.target    = market_pair.target
          contract_stat.market    = ZbgFutures::Market::NAME
          contract_stat.index_identifier = nil
          contract_stat.index_name = nil
          # contract_stat.open_interest
          # contract_stat.index
          # contract_stat.payload
          # contract_stat.funding_rate_percentage
          # contract_stat.next_funding_rate_timestamp
          # contract_stat.funding_rate_percentage_predicted
          contract_stat.contract_type = "perpetual"
          contract_stat
        end
      end
    end
  end
end
