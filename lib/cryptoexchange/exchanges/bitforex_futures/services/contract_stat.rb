module Cryptoexchange::Exchanges
  module BitforexFutures
    module Services
      class ContractStat < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          open_interest = super(open_interest_url(market_pair))
          fund_rate_and_index = super(fund_rate_and_index_url(market_pair))
          adapt(open_interest["data"], fund_rate_and_index["data"], market_pair)
        end

        def open_interest_url(market_pair)
          "https://www.bitforex.com/contract/swap/contract/contractDetail/#{market_pair.inst_id}"
        end

        def fund_rate_and_index_url(market_pair)
          "https://www.bitforex.com/contract/swap/contract/commonInfo/#{market_pair.inst_id}"
        end

        def adapt(open_interest, fund_rate_and_index, market_pair)
          contract_stat = Cryptoexchange::Models::ContractStat.new

          contract_stat.base      = market_pair.base
          contract_stat.target    = market_pair.target
          contract_stat.market    = BitforexFutures::Market::NAME
          contract_stat.open_interest = open_interest['notBalanceNum'].to_f
          contract_stat.index     = fund_rate_and_index['indexPrice'].to_f
          contract_stat.index_identifier = nil
          contract_stat.index_name = nil
          contract_stat.payload   = { open_interest: open_interest, fund_rate_and_index: fund_rate_and_index }
          contract_stat.funding_rate_percentage     = fund_rate_and_index['fundRate'].to_f * 100
          contract_stat.next_funding_rate_timestamp     = fund_rate_and_index['nextFundTime']/1000
          contract_stat.funding_rate_percentage_predicted = nil
          contract_stat.contract_type = "perpetual"
          contract_stat
        end
      end
    end
  end
end
