module Cryptoexchange::Exchanges
  module BithumbFutures
    module Services
      class ContractStat < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(market_data_url(market_pair))
          adapt(output["data"], market_pair)
        end

        def market_data_url(market_pair)
          "https://bithumbfutures.com/api/pro/futures/market-data?symbol=#{market_pair.inst_id}"
        end

        def adapt(output, market_pair)
          contract_stat = Cryptoexchange::Models::ContractStat.new

          contract_stat.base      = market_pair.base
          contract_stat.target    = market_pair.target
          contract_stat.market    = BithumbFutures::Market::NAME
          contract_stat.contract_type = "perpetual"

          contract_stat.open_interest = output["openInterest"].to_f
          contract_stat.index     = output["indexPrice"].to_f
          contract_stat.funding_rate_percentage = output["fundingRate"].to_f * 100
          contract_stat.next_funding_rate_timestamp = output['nextFundingPaymentTime'] / 1000

          contract_stat.payload   = output

          contract_stat
        end
      end
    end
  end
end
