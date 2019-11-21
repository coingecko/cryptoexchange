module Cryptoexchange::Exchanges
  module BitzFutures
    module Services
      class ContractStat < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(market_pair, output)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::BitzFutures::Market::API_URL}/Market/getContractTickers?contractId=#{market_pair.inst_id}"
        end

        def adapt(market_pair, output)
          contract_stat = Cryptoexchange::Models::ContractStat.new
          output = output['data'][0]
          contract_stat.base      = market_pair.base
          contract_stat.target    = market_pair.target
          contract_stat.contract_type = "perpetual"
          contract_stat.market    = BitzFutures::Market::NAME
          contract_stat.open_interest = output['openInterest'].to_f
          contract_stat.index     = output['indexPrice'].to_f
          contract_stat.index_identifier = nil
          contract_stat.index_name = nil

          contract_stat.payload   = output
          contract_stat.expire_timestamp = nil
          contract_stat.start_timestamp = nil

          contract_stat.funding_rate_percentage = nil
          contract_stat.next_funding_rate_timestamp = nil
          contract_stat.funding_rate_percentage_predicted = output['nextFundingRate'].to_f * 100

          contract_stat
        end
      end
    end
  end
end
