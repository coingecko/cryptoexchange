module Cryptoexchange::Exchanges
  module BitmaxFutures
    module Services
      class ContractStat < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "https://bitmax.io/api/pro/futures/market-data?symbol=#{market_pair.inst_id}"
        end

        def adapt(output, market_pair)
          output = output["data"]
          contract_stat = Cryptoexchange::Models::ContractStat.new

          contract_stat.base          = market_pair.base
          contract_stat.target        = market_pair.target
          contract_stat.contract_type = "perpetual"
          contract_stat.market        = BitmaxFutures::Market::NAME

          contract_stat.open_interest = NumericHelper.to_d output["openInterest"]
          contract_stat.index         = NumericHelper.to_d output["indexPrice"]
          contract_stat.funding_rate_percentage = NumericHelper.to_d(output["fundingRate"]) * 100
          contract_stat.next_funding_rate_timestamp = output["nextFundingPaymentTime"].to_i / 1000
          contract_stat.payload       = output

          contract_stat
        end
      end
    end
  end
end
