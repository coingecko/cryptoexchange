module Cryptoexchange::Exchanges
  module Hopex
    module Services
      class ContractStat < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(market_pair, output["data"])
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Hopex::Market::API_URL}/ticker?contractCode=#{market_pair.inst_id}"
        end

        def adapt(market_pair, pair)
          contract_stat = Cryptoexchange::Models::ContractStat.new

          contract_stat.base      = market_pair.base
          contract_stat.target    = market_pair.target
          contract_stat.market    = Hopex::Market::NAME
          contract_stat.open_interest = nil
          contract_stat.index     = pair['marketPrice'].to_f
          contract_stat.index_identifier = nil
          contract_stat.index_name = nil

          contract_stat.payload   = pair
          contract_stat.expire_timestamp = nil
          contract_stat.start_timestamp = nil
          contract_stat.contract_type = "perpetual"

          contract_stat.funding_rate_percentage = nil
          contract_stat.next_funding_rate_timestamp = nil
          contract_stat.funding_rate_percentage_predicted = nil

          contract_stat
        end
      end
    end
  end
end
