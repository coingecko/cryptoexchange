module Cryptoexchange::Exchanges
  module Kumex
    module Services
      class ContractStat < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(contract_stat_url(market_pair.inst_id))
          adapt(output['data'], market_pair,)
        end

        def contract_stat_url(inst_id)
          "https://kitchen.kumex.com/web-front/contracts/#{inst_id}"
        end

        def adapt(output, market_pair)
          contract_stat = Cryptoexchange::Models::ContractStat.new

          contract_stat.base      = market_pair.base
          contract_stat.target    = market_pair.target
          contract_stat.market    = Kumex::Market::NAME
          contract_stat.open_interest = output["openInterest"] ? NumericHelper.to_d(output["openInterest"]) : nil
          contract_stat.index = output["indexPrice"]
          contract_stat.index_identifier = "#{output["indexSymbol"]}".gsub(".","")
          contract_stat.index_name = output["indexSymbol"]
          contract_stat.payload = output
          contract_stat.expire_timestamp = output["expireDate"] ? output["expireDate"] / 1000 : nil
          contract_stat.start_timestamp = output["firstOpenDate"] ? output["firstOpenDate"] / 1000 : nil
          contract_stat.contract_type = contract_type(output["type"], market_pair.inst_id)

          contract_stat.funding_rate_percentage = output["fundingFeeRate"] ? output["fundingFeeRate"] * 100 : nil
          contract_stat.next_funding_rate_timestamp = output["nextFundingRateTime"] ? Time.now.to_i + (output["nextFundingRateTime"] / 1000) : nil
          contract_stat.funding_rate_percentage_predicted = output["predictedFundingFeeRate"] ? output["predictedFundingFeeRate"] * 100 : nil

          contract_stat
        end

        def contract_type(type, inst_id)
          if type == "FFWCSX"
            "perpetual"
          elsif type == "FFICSX"
            "futures"
          end
        end
      end
    end
  end
end
