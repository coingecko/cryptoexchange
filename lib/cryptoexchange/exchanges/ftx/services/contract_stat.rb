module Cryptoexchange::Exchanges
  module Ftx
    module Services
      class ContractStat < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          open_interest = super(open_interest_url(market_pair))
          index = super(index_url(market_pair))

          adapt(open_interest, index, market_pair)
        end

        def open_interest_url(market_pair)
          "#{Cryptoexchange::Exchanges::Ftx::Market::API_URL}/futures/#{market_pair.inst_id}/stats"
        end

        def index_url(market_pair)
          "#{Cryptoexchange::Exchanges::Ftx::Market::API_URL}/futures/#{market_pair.inst_id}"
        end

        def adapt(open_interest, index, market_pair)
          contract_stat = Cryptoexchange::Models::ContractStat.new
          contract_stat.base      = market_pair.base
          contract_stat.target    = market_pair.target
          contract_stat.market    = Ftx::Market::NAME
          contract_stat.open_interest = open_interest['result']['openInterest'].to_f

          contract_stat.payload   = { "open_interest" => open_interest, "index" => index }

          expire_timestamp = index['result']['expiry'] ? DateTime.parse(index['result']['expiry']).to_time.to_i : nil
          start_timestamp = nil

          contract_stat.expire_timestamp = expire_timestamp
          contract_stat.start_timestamp = start_timestamp
          contract_stat.contract_type = contract_type(index['result']['type'])

          contract_stat.index     = index['result']['index'].to_f

          if contract_stat.contract_type == "prediction"
            contract_stat.index_identifier = "#{index['result']['name']}_#{index['result']['underlying'].gsub(' ','_')}"
            contract_stat.index_name       = "#{index['result']['name']} (#{index['result']['underlying']})"
          else
            contract_stat.index_identifier = index['result']['underlying']
            contract_stat.index_name       = index['result']['underlyingDescription']
          end

          contract_stat.funding_rate_percentage = open_interest['result']['nextFundingRate'] ? open_interest['result']['nextFundingRate'] * 100 : nil
          contract_stat.next_funding_rate_timestamp = open_interest['result']['nextFundingTime'] ? DateTime.parse(open_interest['result']['nextFundingTime']).to_time.to_i : nil
          contract_stat.funding_rate_percentage_predicted = nil

          contract_stat
        end

        def contract_type(type)
          if type == "perpetual"
            "perpetual"
          elsif type == "future"
            "futures"
          elsif type == "move"
            "move"
          elsif type == "prediction"
            "prediction"
          end
        end
      end
    end
  end
end
