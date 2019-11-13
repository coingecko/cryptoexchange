module Cryptoexchange::Exchanges
  module BitflyerFutures
    module Services
      class ContractStat < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          contract_type = super(contract_type_url)
          adapt(contract_type, market_pair)
        end

        def get_contract_type(contract_type, inst_id)
          contract = contract_type.select { |resp| resp['product_code'] == inst_id || resp['alias'] == inst_id }.first
          contract = contract["alias"] || contract["product_code"]
          if contract.match /FX/
            "perpetual"
          elsif contract.match /MAT2WK|MAT1WK|MAT3M/
            "futures"
          end
        end

        def contract_type_url
          "#{Cryptoexchange::Exchanges::BitflyerFutures::Market::API_URL}/markets"
        end

        def adapt(contract_type, market_pair)
          contract_stat = Cryptoexchange::Models::ContractStat.new

          contract_stat.base      = market_pair.base
          contract_stat.target    = market_pair.target
          contract_stat.market    = BitflyerFutures::Market::NAME
          contract_stat.index_identifier = "BitflyerFutures~#{market_pair.base}/#{market_pair.target}"
          contract_stat.index_name = "Bitflyer #{market_pair.base}/#{market_pair.target}"
          # contract_stat.open_interest
          # contract_stat.index
          # contract_stat.payload
          # contract_stat.funding_rate_percentage
          # contract_stat.next_funding_rate_timestamp
          # contract_stat.funding_rate_percentage_predicted
          contract_stat.contract_type = get_contract_type(contract_type, market_pair.inst_id)
          contract_stat
        end
      end
    end
  end
end
