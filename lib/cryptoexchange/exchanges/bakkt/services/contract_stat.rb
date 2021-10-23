module Cryptoexchange::Exchanges
  module Bakkt
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
          contract_stat.market    = Bakkt::Market::NAME
          contract_stat.index_identifier = nil
          contract_stat.index_name = nil
          # contract_stat.open_interest = output['openInterest'].to_f
          # contract_stat.index     = output['indicativeSettlePrice'].to_f
          # contract_stat.payload   = output

          # expire_timestamp = output['expiry'] ? DateTime.parse(output['expiry']).to_time.to_i : nil
          # start_timestamp = output['listing'] ? DateTime.parse(output['listing']).to_time.to_i : nil

          # contract_stat.expire_timestamp = expire_timestamp
          # contract_stat.start_timestamp = start_timestamp
          contract_stat.contract_type = "futures"

          # contract_stat.funding_rate_percentage = output['fundingRate'] ? output['fundingRate'] * 100 : nil
          # contract_stat.next_funding_rate_timestamp = output['fundingTimestamp'] ? DateTime.parse(output['fundingTimestamp']).to_time.to_i : nil
          # contract_stat.funding_rate_percentage_predicted = output['indicativeFundingRate'] ? output['indicativeFundingRate'] * 100 : nil

          contract_stat
        end
      end
    end
  end
end
