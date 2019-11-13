module Cryptoexchange::Exchanges
  module BitfinexFutures
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
          "#{Cryptoexchange::Exchanges::BitfinexFutures::Market::API_URL}/status/deriv?keys=#{market_pair.inst_id}"
        end

        def adapt(output, market_pair)
          output = output.first
          contract_stat = Cryptoexchange::Models::ContractStat.new

          contract_stat.base      = market_pair.base
          contract_stat.target    = market_pair.target
          contract_stat.market    = BitfinexFutures::Market::NAME
          contract_stat.open_interest = nil
          contract_stat.index     = output[15].to_f
          contract_stat.index_identifier = "BitfinexFutures-#{market_pair.inst_id}"
          contract_stat.index_name = "BFX Composite (#{market_pair.base})"
          contract_stat.payload   = output

          expire_timestamp = nil
          start_timestamp = nil

          contract_stat.expire_timestamp = expire_timestamp
          contract_stat.start_timestamp = start_timestamp
          contract_stat.contract_type = "perpetual"

          contract_stat.funding_rate_percentage = output[12].to_f * 100
          contract_stat.next_funding_rate_timestamp = output[8]/1000
          contract_stat.funding_rate_percentage_predicted = output[9].to_f * 100

          contract_stat
        end
      end
    end
  end
end
