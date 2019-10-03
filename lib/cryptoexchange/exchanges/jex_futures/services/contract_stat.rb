module Cryptoexchange::Exchanges
  module JexFutures
    module Services
      class ContractStat < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          contract_infos = super(contract_info_url)
          contract_info = contract_infos.select { |ci| ci['symbol'] == market_pair.inst_id }.first

          adapt(contract_info, market_pair)
        end

        def contract_info_url
          "#{Cryptoexchange::Exchanges::JexFutures::Market::API_URL}/contractInfo"
        end

        def adapt(contract_info, market_pair)
          contract_stat = Cryptoexchange::Models::ContractStat.new
          contract_stat.base      = market_pair.base
          contract_stat.target    = market_pair.target
          contract_stat.market    = JexFutures::Market::NAME
          contract_stat.index     = contract_info['markPrice'].to_f
          contract_stat.funding_rate_percentage     = contract_info['fundingRate'].to_f * 100
          contract_stat.next_funding_rate_timestamp     = contract_info['nextFundingTime']/1000
          contract_stat.funding_rate_percentage_predicted = contract_info['predictedFundingRate']/1000
          contract_stat.contract_type = "perpetual"
          contract_stat.payload   =  contract_info
          contract_stat
        end
      end
    end
  end
end
