module Cryptoexchange::Exchanges
  module Bitmex
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
          "#{Cryptoexchange::Exchanges::Bitmex::Market::API_URL}/instrument?symbol=#{market_pair.inst_id}&count=100&reverse=true"
        end

        def adapt(output, market_pair)
          output = output.first
          contract_stat = Cryptoexchange::Models::ContractStat.new

          contract_stat.base      = market_pair.base
          contract_stat.target    = market_pair.target
          contract_stat.market    = Bitmex::Market::NAME
          contract_stat.open_interest = output['openInterest'].to_f
          contract_stat.index     = output['indicativeSettlePrice'].to_f
          contract_stat.funding_rate = output['fundingRate'].to_f
          contract_stat.funding_rate_timestamp = DateTime.parse(output['fundingTimestamp']).to_time.to_i
          contract_stat.next_funding_rate_predicted = output['indicativeFundingRate'].to_f
          contract_stat.payload   = output
          contract_stat
        end
      end
    end
  end
end
