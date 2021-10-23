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
          index_data = super(index_url(market_pair))
          open_interest_data = get_open_interest_data(open_interest_url, market_pair)
          adapt(market_pair, index_data["data"], open_interest_data)
        end

        def index_url(market_pair)
          "#{Cryptoexchange::Exchanges::Hopex::Market::API_URL}/ticker?contractCode=#{market_pair.inst_id}"
        end

        def open_interest_url
          "#{Cryptoexchange::Exchanges::Hopex::Market::API_URL}/markets"
        end

        def get_open_interest_data(open_interest_url, market_pair)
          output = JSON.parse(HTTP.get(open_interest_url))
          output["data"].find { |data| data if data["contractCode"] == market_pair.inst_id }
        end

        def adapt(market_pair, index_data, open_interest_data)
          contract_stat = Cryptoexchange::Models::ContractStat.new

          contract_stat.base      = market_pair.base
          contract_stat.target    = market_pair.target
          contract_stat.market    = Hopex::Market::NAME
          contract_stat.open_interest = open_interest_data["posVauleUSD"].delete(',').to_f
          contract_stat.index     = index_data['marketPrice'].to_f
          contract_stat.index_identifier = nil
          contract_stat.index_name = nil

          contract_stat.payload   = [index_data, open_interest_data]
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
